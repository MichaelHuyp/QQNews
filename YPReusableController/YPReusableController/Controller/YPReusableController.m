//
//  YPReusableController.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "YPReusableController.h"
#import <objc/runtime.h>
#import "YPStyleBar.h"
#import "YPContainerView.h"
#import "YPSideController.h"

@interface UIViewController ()

@property (nonatomic, strong, readwrite) YPReusableController *reusableController;

@end

@interface YPReusableController () <YPStyleBarDelegate, UIScrollViewDelegate>

/** 顶部索引条 */
@property (nonatomic, weak) YPStyleBar *bar;

/** 底部容器 */
@property (nonatomic, weak) YPContainerView *containerView;

/** 开始拖动时的偏移量 */
@property (nonatomic, assign) CGFloat startContentOffsetX;

@property (nonatomic, copy) YPReusableControllerNormalBlock leftBtnTouchBlock;

@property (nonatomic, copy) YPReusableControllerNormalBlock rightBtnTouchBlock;

@end

@implementation YPReusableController


#pragma mark - Override

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc
{
    [self removeObservers];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view bringSubviewToFront:self.bar];
    
}

#pragma mark - Public
- (instancetype)initWithParentViewController:(UIViewController *)parentViewController
{
    self = [super init];
    if (!self) return nil;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;
    parentViewController.reusableController = self;
    parentViewController.automaticallyAdjustsScrollViewInsets = NO;
    [parentViewController addChildViewController:self];
    [parentViewController.view addSubview:self.view];
    
    // bar
    YPStyleBar *bar = [[YPStyleBar alloc] init];
    self.bar = bar;
    bar.myDelegate = self;
    [self.view addSubview:bar];
    
    // containerView
    YPContainerView *containerView = [[YPContainerView alloc] init];
    self.containerView = containerView;
    containerView.delegate = self;
    [self.view addSubview:containerView];
    containerView.yp_y = bar.yp_bottom;
    containerView.yp_height = YPScreenH - bar.yp_bottom;
    
    // 添加监听
    [self addObservers];
    
    return self;
}

#pragma mark - KVO
- (void)removeObservers
{
    [self.containerView removeObserver:self forKeyPath:YPKeyPathContentOffset];
    [YPNotificationCenter removeObserver:self];
}

- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.containerView addObserver:self forKeyPath:YPKeyPathContentOffset options:options context:nil];
    
    [YPNotificationCenter addObserver:self selector:@selector(ypStyleBarLeftBtnDidTouchNotification) name:YPStyleBarLeftBtnDidTouchNotification object:nil];
    
    [YPNotificationCenter addObserver:self selector:@selector(ypStyleBarRightBtnDidTouchNotification) name:YPStyleBarRightBtnDidTouchNotification object:nil];
    
    [YPNotificationCenter addObserver:self selector:@selector(ypSideControllerWillHideMenuNotification) name:YPSideControllerWillHideMenuNotification object:nil];
    
    [YPNotificationCenter addObserver:self selector:@selector(ypSideControllerWillShowMenuNotification) name:YPSideControllerWillShowMenuNotification object:nil];
}

- (void)ypSideControllerWillHideMenuNotification
{
    [UIView animateWithDuration:0.35f animations:^{
        self.bar.backgroundColor = YPWhiteColor;
    }];
}

- (void)ypSideControllerWillShowMenuNotification
{
    [UIView animateWithDuration:0.35f animations:^{
        self.bar.backgroundColor = YPClearColor;
    }];
}

- (void)ypStyleBarLeftBtnDidTouchNotification
{
    if (_leftBtnTouchBlock) {
        _leftBtnTouchBlock();
    }
}

- (void)ypStyleBarRightBtnDidTouchNotification
{
    if (_rightBtnTouchBlock) {
        _rightBtnTouchBlock();
    }
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    if ([object isKindOfClass:[YPContainerView class]] && [keyPath isEqualToString:YPKeyPathContentOffset])
    {
        
        // 记录offsetX
        CGFloat offsetX = self.containerView.yp_offsetX;
        
        // 记录进度
        CGFloat progress = offsetX / self.containerView.yp_width;
        
        _currentIndex = self.containerView.yp_offsetX / (YPScreenW + 1);
        
        // 左方目前的index
        int leftCurrentIndex = self.containerView.yp_offsetX / (YPScreenW - 1);
        
        if (progress == (NSUInteger)progress) {
            self.bar.progress = progress;
        }
        
        // 边界直接返回
        if ((_startContentOffsetX / self.containerView.yp_width) == progress) return;

        
        [_subViewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (_startContentOffsetX < self.containerView.yp_offsetX) {
                if (_currentIndex >= idx) return;
                UIViewController* vc = (UIViewController*)self.subViewControllers[_currentIndex + 1];
                vc.view.frame = CGRectMake(YPScreenW * (_currentIndex + 1), 0, self.containerView.yp_width, self.containerView.yp_height);
                [self.containerView addSubview:vc.view];
                [self addChildViewController:vc];
            } else {
                UIViewController* vc = (UIViewController*)self.subViewControllers[leftCurrentIndex];
                vc.view.frame = CGRectMake(YPScreenW * leftCurrentIndex, 0, self.containerView.yp_width, self.containerView.yp_height);
                [self.containerView addSubview:vc.view];
                [self addChildViewController:vc];
            }
        }];
        
    }
}


#pragma mark - setter
- (void)setSubViewControllers:(NSArray *)subViewControllers
{
    // nil || 数组元素个数为0 || 旧数组与新数组相等 return;
    if (!subViewControllers || subViewControllers.count == 0 || [_subViewControllers isEqualToArray:subViewControllers]) return;
    
    // 保存
    _subViewControllers = subViewControllers;
    
    // 取出subViewController数组内所有控制器的标题
    NSMutableArray *titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *vc in _subViewControllers) {
        [titles addObject:vc.yp_Title];
    }
    
    // 将标题数组赋值给bar
    self.bar.items = titles;
    self.containerView.contentSize = CGSizeMake(YPScreenW * _subViewControllers.count, 0);
}

- (void)setTextInset:(CGFloat)textInset
{
    _textInset = textInset;
    
    self.bar.textInset = textInset;
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    
    self.bar.textFont = textFont;
}

- (void)setTextColor_normal:(UIColor *)textColor_normal
{
    _textColor_normal = textColor_normal;
    
    self.bar.textColor_normal = textColor_normal;
}

- (void)setTextColor_selected:(UIColor *)textColor_selected
{
    _textColor_selected = textColor_selected;
    
    self.bar.textColor_selected = textColor_selected;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    if (currentIndex >= self.subViewControllers.count) return;
    
    _currentIndex = currentIndex;
    
    self.bar.currentItemIndex = currentIndex;
    
    if ([self.bar.myDelegate respondsToSelector:@selector(itemDidSelectedWithIndex:index:)])
    {
        [self.bar.myDelegate itemDidSelectedWithIndex:self.bar index:currentIndex];
    }
}

- (void)setBar_bgColor:(UIColor *)bar_bgColor
{
    _bar_bgColor = bar_bgColor;
    
    self.bar.backgroundColor = bar_bgColor;
}

- (void)setBar_scrollViewBgColor:(UIColor *)bar_scrollViewBgColor
{
    _bar_scrollViewBgColor = bar_scrollViewBgColor;
    
    self.bar.scrollViewBgColor = bar_scrollViewBgColor;
}

- (void)setLeftImage_normal:(UIImage *)leftImage_normal
{
    if (!leftImage_normal) return;
    
    _leftImage_normal = leftImage_normal;
    
    self.bar.leftImage_normal = leftImage_normal;
}

- (void)setRightImage_normal:(UIImage *)rightImage_normal
{
    if (!rightImage_normal) return;
    
    _rightImage_normal = rightImage_normal;
    
    self.bar.rightImage_normal = _rightImage_normal;
}

- (void)setRightImage_highlight:(UIImage *)rightImage_highlight
{
    if (!rightImage_highlight) return;
    
    _rightImage_highlight = rightImage_highlight;
    
    self.bar.rightImage_highlight = _rightImage_highlight;
}

- (void)setLeftBtnTouchBlock:(YPReusableControllerNormalBlock)leftBtnTouchBlock
{
    _leftBtnTouchBlock = leftBtnTouchBlock;
}

- (void)setRightBtnTouchBlock:(YPReusableControllerNormalBlock)rightBtnTouchBlock
{
    _rightBtnTouchBlock = rightBtnTouchBlock;
}

- (void)setIsOpenShadowEffect:(BOOL)isOpenShadowEffect
{
    _isOpenShadowEffect = isOpenShadowEffect;
    
    self.bar.isOpenShadowEffect = isOpenShadowEffect;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{ // 记录拖动前的起始坐标
    
    _startContentOffsetX = scrollView.contentOffset.x;
}


#pragma mark - YPStyleBarDelegate
- (void)itemDidSelectedWithIndex:(YPStyleBar *)navTabBar index:(NSUInteger)index
{
    _currentIndex = index;
    
    // 加载子控制器中的视图
    UIViewController *selectedVc = _subViewControllers[_currentIndex];
    [self addChildViewController:selectedVc];
    [self.containerView addSubview:selectedVc.view];
    selectedVc.view.frame = CGRectMake(YPScreenW * index, 0, self.containerView.yp_width, self.containerView.yp_height);
    [self.containerView setContentOffset:CGPointMake(YPScreenW * index, 0)];
    
    self.bar.currentItemIndex = index;
}

@end

@implementation UIViewController (YPReusableControllerExtension)

// 关联
YPSYNTH_DYNAMIC_PROPERTY_OBJECT(yp_Title, setYp_Title, COPY_NONATOMIC, NSString *);

YPSYNTH_DYNAMIC_PROPERTY_OBJECT(reusableController, setReusableController, RETAIN_NONATOMIC, YPReusableController *);

@end




#if 0
#warning 先不考虑屏幕旋转 以后fix
/**
 *  监听屏幕旋转的方法
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    self.bar.yp_width = width;
    self.containerView.yp_width = width;
    self.containerView.yp_height = height - self.bar.yp_bottom;
    
    // 设置containerView的content
    self.containerView.contentSize = CGSizeMake(_subViewControllers.count * width, 0);
    
    UIViewController *selectedVc = _subViewControllers[_currentIndex];
    
    selectedVc.view.frame = CGRectMake(_currentIndex * selectedVc.view.superview.yp_width, 0, selectedVc.view.superview.yp_width, selectedVc.view.superview.yp_height);
    
    [self.containerView setContentOffset:CGPointMake(_currentIndex * selectedVc.view.superview.yp_width, 0) animated:NO];
}
#endif






























