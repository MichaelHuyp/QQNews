//
//  YPStyleBar.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "YPStyleBar.h"
#import "YPStyleBtn.h"
#import "YPIconBtn.h"

@interface YPStyleBar()

/** 左侧按钮 */
@property (nonatomic, weak) YPIconBtn *leftBtn;
/** 右侧按钮 */
@property (nonatomic, weak) UIButton *rightBtn;
/** 所有的选项标题都在这个ScrollView上 */
@property (nonatomic, weak) UIScrollView *itemContainerView;
/** 椭圆指示条 */
@property (nonatomic, weak) UIView *ellipseIndicateView;
/** 保存所有Item文字高度的数组 */
@property (nonatomic, strong) NSMutableArray *allItemTextHeightArr;
/** 保存所有Item文字宽度的数组 */
@property (nonatomic, strong) NSMutableArray *allItemTextWidthArr;
/** 调整文字误差padding */
@property (nonatomic, assign) CGFloat padding;
/** bar底部的那条线 */
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation YPStyleBar

#pragma mark - Lazy

- (NSMutableArray *)allItemTextWidthArr
{
    if (!_allItemTextWidthArr) {
        _allItemTextWidthArr = [NSMutableArray array];
    }
    return _allItemTextWidthArr;
}

- (NSMutableArray *)allItemTextHeightArr
{
    if (!_allItemTextHeightArr) {
        _allItemTextHeightArr = [NSMutableArray array];
    }
    return _allItemTextHeightArr;
}

- (NSMutableArray *)allItemBtnArr
{
    if (!_allItemBtnArr) {
        _allItemBtnArr = [NSMutableArray array];
    }
    return _allItemBtnArr;
}

#pragma mark - Override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self prepare];
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) { // 新的父控件
        self.yp_width = newSuperview.yp_width;
        self.yp_left = 0;
        self.yp_height = YPStyleBarHeight;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.itemContainerView.frame = CGRectMake(0, 20, self.yp_right, 44);
    
    self.ellipseIndicateView.yp_centerY = self.itemContainerView.yp_height * 0.5;
    
    self.leftBtn.frame = CGRectMake(0, 20, YPStyleBarLeftOrRightBtnWH, YPStyleBarLeftOrRightBtnWH);
    self.rightBtn.frame = CGRectMake(self.yp_right - YPStyleBarLeftOrRightBtnWH, 20, YPStyleBarLeftOrRightBtnWH, YPStyleBarLeftOrRightBtnWH);
    
    for (UIView *view in self.itemContainerView.subviews) {
        if ([view isKindOfClass:[YPStyleBtn class]]) {
            view.yp_height = view.superview.yp_height;
        }
    }
    
    self.bottomLine.frame = CGRectMake(0, self.yp_bottom - 0.5 , self.yp_width, 0.5);
}

- (void)dealloc
{
    [YPNotificationCenter removeObserver:self];
}

#pragma mark - Private
- (void)prepare
{
    // self
    self.backgroundColor = YPWhiteColor;
    
    if (iPHone4 || iPHone5) {
        _padding = 180;
    } else if (iPHone6)
    {
        _padding = 100;
    } else if (iPHone6Plus) {
        _padding = 44;
    }
    
    _isOpenShadowEffect = YES;
    
    // 初始化内边距为10
    _textInset = 10.0f;
    // 初始化文字字体
    _textFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    // 初始化文字普通状态时的颜色
    _textColor_normal = [UIColor grayColor];
    // 初始化文字选中状态时的颜色
    _textColor_selected = [UIColor blueColor];
    
    // container
    UIScrollView *itemContainerView = [[UIScrollView alloc] init];
    self.itemContainerView = itemContainerView;
    [self addSubview:itemContainerView];
    itemContainerView.showsHorizontalScrollIndicator = NO;
    itemContainerView.showsVerticalScrollIndicator = NO;
    itemContainerView.backgroundColor = YPWhiteColor;
    
    // leftBtn
    YPIconBtn *leftBtn = [YPIconBtn iconBtn];
    self.leftBtn = leftBtn;
    [self addSubview:leftBtn];
    leftBtn.hidden = NO;
    [leftBtn addTarget:self action:@selector(leftBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = YPWhiteColor;
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    
    // rightBtn
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    [self addSubview:rightBtn];
    rightBtn.hidden = NO;
    [rightBtn addTarget:self action:@selector(rightBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = YPWhiteColor;
    
    // line
    UIView *bottomLine = [[UIView alloc] init];
    self.bottomLine = bottomLine;
    [self addSubview:bottomLine];
    bottomLine.backgroundColor = YPLightGrayColor;
    
    // shadow
    if (_isOpenShadowEffect) {
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = YPBlackColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowOpacity = 0.7;
    }
}


/**
 *  根据标题文字数组得到按钮宽度数组
 *
 *  @param titles 文字数组
 *
 *  @return 按钮宽度数组
 */
- (NSArray *)getBtnWidthArrWithTitles:(NSArray *)titles
{
    for (NSString *title in titles) {
        CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = _textFont;
        size = [title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        NSNumber *width = [NSNumber numberWithFloat:size.width + 2 * _textInset];
        NSNumber *height = [NSNumber numberWithFloat:size.height];
        [self.allItemTextWidthArr addObject:width];
        [self.allItemTextHeightArr addObject:height];
    }
    
    
    return [self.allItemTextWidthArr copy];
}

/**
 *  放置按钮方法
 *
 *  @param widths 装有按钮宽度的数组
 *
 *  @return 返回总长度(作为scrollView的contentsize)
 */
- (CGFloat)setUpBtnWithBtnWidthArr:(NSArray *)widths andBtnHeightArr:(NSArray *)heights
{
    CGFloat buttonX = 0.0f;
    CGFloat totalWidth = 0.0f;
    
    for (NSUInteger index = 0; index < widths.count; index++)
    {
        YPStyleBtn *styleBtn = [YPStyleBtn styleBtn];
        [self.itemContainerView addSubview:styleBtn];
        styleBtn.frame = CGRectMake(YPStyleBarLeftOrRightBtnWH + buttonX, 0, [widths[index] floatValue], styleBtn.superview.yp_height);
        [styleBtn setTitle:_items[index] forState:UIControlStateNormal];
        [styleBtn addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        styleBtn.titleLabel.font = _textFont;
        [styleBtn setTitleColor:_textColor_normal forState:UIControlStateNormal];
        [styleBtn setTitleColor:_textColor_selected forState:UIControlStateSelected];
        
        buttonX += [widths[index] floatValue];
        
        [self.allItemBtnArr addObject:styleBtn];
        
        if (index == widths.count - 1) {
            totalWidth = styleBtn.yp_right;
        }
    }
    
    // 显示圆圈指示条
    [self showEllipseIndicateViewWithButtonWidth:[widths[0] floatValue] andHeight:[heights[0] floatValue]];
    
    return totalWidth + YPStyleBarLeftOrRightBtnWH;
}

/**
 *  显示圆圈指示条
 *
 *  @param width 给定的指示条宽度
 */
- (void)showEllipseIndicateViewWithButtonWidth:(CGFloat)width andHeight:(CGFloat)height
{
    // container.subview -> indicateView
    UIView *ellipseIndicateView = [[UIView alloc] init];
    self.ellipseIndicateView = ellipseIndicateView;
    [self.itemContainerView addSubview:ellipseIndicateView];
    ellipseIndicateView.layer.cornerRadius = 10;
    ellipseIndicateView.backgroundColor = YPColor_RGBA(200, 200, 200, 0.3);
    ellipseIndicateView.userInteractionEnabled = NO;
    ellipseIndicateView.hidden = NO;
    
    
    self.ellipseIndicateView.yp_x = YPStyleBarLeftOrRightBtnWH + 2.0f;
    self.ellipseIndicateView.yp_width = width - 4.0f;
    self.ellipseIndicateView.yp_height = height + YPPadding;
}

/**
 *  刷新数据源
 */
- (void)reloadData
{
    // 清空旧数据
    [self.allItemBtnArr removeAllObjects];
    [self.allItemTextHeightArr removeAllObjects];
    [self.itemContainerView removeAllSubviews];
    
    // 按钮宽度数组
    NSArray *widths = [self getBtnWidthArrWithTitles:[_items copy]];
    NSArray *heights = [self.allItemTextHeightArr copy];
    
    // 放置按钮
    CGFloat totalWidth = [self setUpBtnWithBtnWidthArr:widths andBtnHeightArr:heights];
    
    // 设置容器scrollView的contentSize
    self.itemContainerView.contentSize = CGSizeMake(totalWidth, 0);
}

- (void)leftBtnTouch
{
//    YPLog(@"左侧按钮被点击");
    [YPNotificationCenter postNotificationName:YPStyleBarLeftBtnDidTouchNotification object:nil];
}

- (void)rightBtnTouch
{
//    YPLog(@"右侧按钮被点击");
    [YPNotificationCenter postNotificationName:YPStyleBarRightBtnDidTouchNotification object:nil];
}

- (void)itemPressed:(YPStyleBtn *)button
{
    NSUInteger index = [self.allItemBtnArr indexOfObject:button];
    
    if ([_myDelegate conformsToProtocol:@protocol(YPStyleBarDelegate)] && [_myDelegate respondsToSelector:@selector(itemDidSelectedWithIndex:index:)]) {
        [_myDelegate itemDidSelectedWithIndex:self index:index];
    }
}

#pragma mark - setter
- (void)setItems:(NSMutableArray *)items
{
    if (!items || items.count == 0 || [_items isEqualToArray:items]) return;
    
    _items = items;
    
    // 刷新数据源
    [self reloadData];
}

- (void)setTextInset:(CGFloat)textInset
{
    _textInset = textInset;
    
    // 刷新数据源
    [self reloadData];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    
    // 刷新数据源
    [self reloadData];
}

- (void)setTextColor_normal:(UIColor *)textColor_normal
{
    _textColor_normal = textColor_normal;
    
    // 刷新数据源
    [self reloadData];
}

- (void)setTextColor_selected:(UIColor *)textColor_selected
{
    _textColor_selected = textColor_selected;
    
    // 刷新数据源
    [self reloadData];
}

- (void)setScrollViewBgColor:(UIColor *)scrollViewBgColor
{
    _scrollViewBgColor = scrollViewBgColor;
    
    self.itemContainerView.backgroundColor = scrollViewBgColor;
}

- (void)setLeftImage_normal:(UIImage *)leftImage_normal
{
    if (!leftImage_normal) return;
    
    _leftImage_normal = leftImage_normal;
    
    [self.leftBtn setImage:_leftImage_normal forState:UIControlStateNormal];
}

- (void)setRightImage_normal:(UIImage *)rightImage_normal
{
    if (!rightImage_normal) return;
    
    _rightImage_normal = rightImage_normal;
    
    [self.rightBtn setImage:_rightImage_normal forState:UIControlStateNormal];
}

- (void)setRightImage_highlight:(UIImage *)rightImage_highlight
{
    if (!rightImage_highlight) return;
    
    _rightImage_highlight = rightImage_highlight;
    
    [self.rightBtn setImage:_rightImage_highlight forState:UIControlStateHighlighted];
}

- (void)setIsOpenShadowEffect:(BOOL)isOpenShadowEffect
{
    _isOpenShadowEffect = isOpenShadowEffect;
    
    self.layer.masksToBounds = !isOpenShadowEffect;
}

/**
 *  根据进度做事情
 */
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat maxOffsetX = self.itemContainerView.yp_contentW - self.itemContainerView.yp_width;
    
    _currentItemIndex = (NSUInteger)progress;
    
    // 当前选中的按钮
    YPStyleBtn *btn = self.allItemBtnArr[_currentItemIndex];
    
    // 坐标系转换
    CGRect btnRect = [btn.superview convertRect:btn.frame toView:self];
    
    CGFloat btnCenterX = btnRect.origin.x + btn.yp_width * 0.5;
    
    
    if (!(btnCenterX > YPScreenW * 0.5 - 20 && btnCenterX < YPScreenW * 0.5 + 20)) { // 判断选中的按钮在屏幕参照坐标系不在中间
        if ((btn.yp_x - 44) <= self.itemContainerView.yp_width * 0.3)
        {
            [self.itemContainerView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else if ((self.itemContainerView.yp_width - btn.yp_x + _padding) <= 0)
        {
            [self.itemContainerView setContentOffset:CGPointMake(maxOffsetX, 0) animated:YES];
        }
        else
        {
            [self.itemContainerView setContentOffset:CGPointMake(btn.yp_x + btn.yp_width * 0.5 - self.itemContainerView.yp_width * 0.5, 0) animated:YES];
        }
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        // 调整按钮
        for (NSUInteger i = 0; i < self.allItemBtnArr.count; i++) {
            
            UIButton *btn = self.allItemBtnArr[i];
            
            btn.selected = (i == _currentItemIndex) ?  YES : NO;
        }
        self.ellipseIndicateView.yp_centerX = btn.yp_centerX;
        self.ellipseIndicateView.yp_width = [_allItemTextWidthArr[_currentItemIndex] floatValue];
    }];
}



@end

NSString *const YPStyleBarLeftBtnDidTouchNotification = @"YPStyleBarLeftBtnDidTouchNotification";
NSString *const YPStyleBarRightBtnDidTouchNotification = @"YPStyleBarRightBtnDidTouchNotification";
























