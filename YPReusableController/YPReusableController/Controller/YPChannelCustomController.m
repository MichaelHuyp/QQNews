//
//  YPChannelCustomController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPChannelCustomController.h"
#import "YPChannelCell.h"
#import "YPReusableControllerConst.h"
#import "YPChannelFooterView.h"

@interface YPChannelCustomController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArr;

/** 记录被选择的cell */
@property (nonatomic, weak) YPChannelCell *selectedCell;

@property (nonatomic, strong) NSMutableArray *cellArr;

@property (nonatomic, strong) NSMutableArray *cellFrameArr;

@property (nonatomic, weak) NSIndexPath *selectedIndexPath;


@end

@implementation YPChannelCustomController
{
    /** 记录开始点击的point */
    CGPoint _startTouchPoint;
    
    /** 触碰检测flag */
    BOOL _insideFlag;
    
    /** 记录最后一次的位置 */
    CGRect _lastRect;
    
    /** 记录第一次触碰的真实坐标 */
    CGRect _firstTouchRealRect;
}


#pragma mark - Lazy 

- (NSMutableArray *)cellFrameArr
{
    if (!_cellFrameArr) {
        _cellFrameArr = [NSMutableArray array];
    }
    return _cellFrameArr;
}

- (NSMutableArray *)cellArr
{
    if (!_cellArr) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}



#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = [YPCacheTool channelTitleArray];
    
    if (!titleArray) return;
    
    self.dataArr = [titleArray mutableCopy];
    
    self.view.backgroundColor = YPWhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createNavBarWithTitle:@"频道定制"];
    
    [self createUI];
}

- (void)dealloc
{
    [self removeObservers];
}


#pragma mark - KVO
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.collectionView addObserver:self forKeyPath:YPKeyPathContentSize options:options context:nil];
}

- (void)removeObservers
{
    [self.collectionView removeObserver:self forKeyPath:YPKeyPathContentSize];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([object isKindOfClass:[UICollectionView class]] && [keyPath isEqualToString:YPKeyPathContentSize])
    {
        CGSize newSize = [[change objectForKey:@"new"] CGSizeValue];
        self.collectionView.yp_height = newSize.height;
    }
}

#pragma mark - Private
- (void)createUI
{
    // UICollectionView 必须在初始化时有一个布局参数
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(YPPadding_3, 12, YPPadding_3, 12);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.footerReferenceSize = CGSizeMake(YPScreenW, 100);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, YPScreenW, YPScreenH - 64) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = YPWhiteColor;
    
    // 注册footerView
    [collectionView registerClass:[YPChannelFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.25f;
    [self.collectionView addGestureRecognizer:longPressGesture];
    
    // 添加监听
    [self addObservers];
}




- (void)longPressGesture:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            self.selectedIndexPath = selectedIndexPath;
            if (selectedIndexPath) {
                if (kiOS9Later) {
                    [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
                } else {
                    // 记录开始点击的point
                    _startTouchPoint = [gesture locationInView:gesture.view];
                    
                    [self beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
                }
            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (kiOS9Later) {
                [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            } else {
                [self updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
            }

            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            if (kiOS9Later) {
                [self.collectionView endInteractiveMovement];
            } else {
                [self endInteractiveMovement];
            }
            break;
        }
        default:
        {
            if (kiOS9Later) {
                [self.collectionView cancelInteractiveMovement];
            } else {
                [self endInteractiveMovement];
            }
            break;
        }

    }
}

- (void)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.清空操作
    [self.cellArr removeAllObjects];
    [self.cellFrameArr removeAllObjects];
    
    // 1.拿到cell
    YPChannelCell *selectedCell =  (YPChannelCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPath];
    self.selectedCell = selectedCell;
    
    __weak typeof(selectedCell) weakCell = selectedCell;
    
    
    // 存储所有cell 此处应该从数据源中提取
    for (UIView *cellView in self.collectionView.subviews) {
        if ([cellView isKindOfClass:[YPChannelCell class]]) {
            [self.cellArr addObject:cellView];
        }
    }
    
    // 存储所有的cellFrame
    for (UIView *cellView in self.collectionView.subviews) {
        if ([cellView isKindOfClass:[YPChannelCell class]]) {
            NSValue *value = [NSValue valueWithCGRect:cellView.frame];
            [self.cellFrameArr addObject:value];
        }
    }
    
    
    {
        NSMutableArray *cellTempArr = [NSMutableArray arrayWithCapacity:self.cellArr.count];
        NSMutableArray *cellFrameTempArr = [NSMutableArray arrayWithCapacity:self.cellFrameArr.count];
        
        for (NSUInteger i = 0; i < self.dataArr.count; i++) {
            for (YPChannelCell *cell in self.cellArr) {
                if ([cell.title isEqualToString:self.dataArr[i]]) {
                    [cellTempArr addObject:cell];
                    NSValue *value = [NSValue valueWithCGRect:cell.frame];
                    [cellFrameTempArr addObject:value];
                }
            }
        }
        
        self.cellArr = [cellTempArr mutableCopy];
        self.cellFrameArr = [cellFrameTempArr mutableCopy];
    }
    
    // 1.5 将cell置前
    [self.collectionView bringSubviewToFront:weakCell];
    
    // 2.调整cell的样式
    [UIView animateWithDuration:0.2f animations:^{
        weakCell.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        weakCell.transform = CGAffineTransformTranslate(weakCell.transform, weakCell.yp_width * 0.05f, weakCell.yp_height * 0.05f);
        weakCell.layer.masksToBounds = NO;
        weakCell.layer.shadowColor = YPLightGrayColor.CGColor;
        weakCell.layer.shadowOffset = CGSizeMake(0.01, 0.01);
        weakCell.layer.shadowOpacity = 0.7;
    }];
}

- (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition
{
    if (!self.selectedIndexPath) return;
    // 移动cell
    CGPoint changePoint = targetPosition;
    
    self.selectedCell.yp_x += changePoint.x - _startTouchPoint.x;
    self.selectedCell.yp_y += changePoint.y - _startTouchPoint.y;
    
    _startTouchPoint = CGPointMake(changePoint.x, changePoint.y);
    
    
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[YPChannelCell class]] && obj != self.selectedCell) {
            // 如果obj的中心点在selectedCell上
            
            CGPoint convertPoint = [self.selectedCell convertPoint:obj.center fromView:self.collectionView];
            
            _insideFlag = [self.selectedCell pointInside:convertPoint withEvent:nil];
            
            if (_insideFlag == YES) { // 说明触碰到了第一个点
                
                // 先拿到触碰到的cell
                YPChannelCell *firstTouchCell = (YPChannelCell *)obj;
                
                // 保存触碰到cell的坐标
                _firstTouchRealRect = firstTouchCell.frame;
                
                _lastRect = CGRectZero;
                
                if ([self.cellArr indexOfObject:self.selectedCell] < [self.cellArr indexOfObject:firstTouchCell])
                { // 选中的cell在触碰cell之前
                    for (NSUInteger i = 0; i < self.cellArr.count; i++) {
                        
                        // 如果在选中之前的cell 跳过本次循环
                        if (i <= [self.cellArr indexOfObject:self.selectedCell]) continue;
                        
                        YPChannelCell *cellAfter = self.cellArr[i];
                        
                        CGRect frameBefore;
                        if (CGRectEqualToRect(_lastRect, CGRectZero)) {
                            frameBefore = [self.cellFrameArr[i-1] CGRectValue];
                        } else {
                            frameBefore = _lastRect;
                        }
                        [UIView animateWithDuration:0.25f animations:^{
                            cellAfter.frame = frameBefore;
                        }];
                        
                        // 如果到了触摸的cell 就可以跳出循环了
                        if (self.cellArr[i] == firstTouchCell) {
                            [self dealWithJumpCycleLogic:i];
                            return;
                        }
                    }
                }
                else
                { // 选中cell在触碰cell之后
                    for (NSUInteger i = self.cellArr.count - 1; i < self.cellArr.count; i--) {
                        
                        // 如果在选中之前的cell 跳过本次循环
                        if (i >= [self.cellArr indexOfObject:self.selectedCell]) continue;
                        
                        YPChannelCell *cellBefore = self.cellArr[i];
                        
                        CGRect frameAfter;
                        if (CGRectEqualToRect(_lastRect, CGRectZero)) {
                            frameAfter = [self.cellFrameArr[i+1] CGRectValue];
                        } else {
                            frameAfter = _lastRect;
                        }
                        
                        [UIView animateWithDuration:0.25f animations:^{
                            cellBefore.frame = frameAfter;
                        }];
                        
                        // 如果到了触摸的cell 就可以跳出循环了
                        if (self.cellArr[i] == firstTouchCell) {
                            [self dealWithJumpCycleLogic:i];
                            return;
                        }
                    }
                }
            }
        }
    }];
}

- (void)endInteractiveMovement
{
    if (!self.selectedIndexPath) return;
    [UIView animateWithDuration:0.35f animations:^{
        self.selectedCell.transform = CGAffineTransformIdentity;
        NSUInteger index = [self.cellArr indexOfObject:self.selectedCell];
        self.selectedCell.frame = [[self.cellFrameArr objectAtIndex:index] CGRectValue];
        self.selectedCell.layer.masksToBounds = YES;
    } completion:^(BOOL finished) {
        [self.collectionView sendSubviewToBack:self.selectedCell];
        
        
        [self.dataArr removeAllObjects];
        for (YPChannelCell *cell in self.cellArr) {
            [self.dataArr addObject:cell.title];
        }
        
        [self.collectionView removeAllSubviews];
        
        [self.collectionView reloadData];
    }];
}

- (void)dealWithJumpCycleLogic:(NSUInteger)index
{
    _insideFlag = NO;
    // 保存上次移动的CGRect
    _lastRect = _firstTouchRealRect;
    // 重新排列数组
    [self.cellArr removeObjectAtIndex:[self.cellArr indexOfObject:self.selectedCell]];
    [self.cellArr insertObject:self.selectedCell atIndex:index];
    
    [self.cellFrameArr removeAllObjects];
    
    for (YPChannelCell *cell in self.cellArr) {
        [self.cellFrameArr addObject:[NSValue valueWithCGRect:cell.frame]];
    }
    
    [self.cellFrameArr replaceObjectAtIndex:[self.cellArr indexOfObject:self.selectedCell] withObject:[NSValue valueWithCGRect:_firstTouchRealRect]];
}


#pragma mark - UICollectionViewDataSource
#pragma mark @required
// 2
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

// 6
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPChannelCell *cell = [YPChannelCell channelCellWithCollectionView:collectionView andIndexPath:indexPath];
    
    cell.title = self.dataArr[indexPath.item];
    
    // 重新布局cell frame
    if (self.cellFrameArr.count > 0) cell.frame = [self.cellFrameArr[indexPath.item] CGRectValue];
    
    return cell;
}




#pragma mark @optional
// 1
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0)
{
    NSString *title = [self.dataArr objectAtIndex:sourceIndexPath.item];
    
    [self.dataArr removeObjectAtIndex:sourceIndexPath.item];
    
    [self.dataArr insertObject:title atIndex:destinationIndexPath.item];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    YPChannelFooterView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        YPChannelFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        reusableview = footerView;
    }
    
    reusableview.backgroundColor = YPWhiteColor;
    
    return reusableview;
}

#pragma mark - UICollectionViewDelegate
#pragma mark @optional

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YPLog(@"%@",indexPath);
}

// 3
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPHone6Plus) {
        return CGSizeMake(80, 44);
    } else if (iPHone6) {
        return CGSizeMake(70, 40);
    } else if (iPHone5 || iPHone4) {
        return CGSizeMake(60, 36);
    }
    return CGSizeZero;
}

// 5
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12.0f;
}

// 4
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12.0f;
}



@end











































