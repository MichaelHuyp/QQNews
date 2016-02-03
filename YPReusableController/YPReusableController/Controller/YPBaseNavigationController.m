//
//  YPBaseNavigationController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseNavigationController.h"
#import "YPReusableControllerConst.h"
#import <objc/runtime.h>

@interface YPBaseNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) NSMutableArray *screenShotList;

/** 正在拖动 */
@property (nonatomic, assign) BOOL isMoving;

/** 开始触摸的点 */
@property (nonatomic, assign) CGPoint startTouchPoint;

/** 背景容器 */
@property (nonatomic, weak) UIView *bgContainer;

/** push之前的屏幕快照imageView */
@property (nonatomic, weak) UIImageView *lastScreenShotView;

/** 黑色遮罩 */
@property (nonatomic, weak) UIView *blackMask;

@property (nonatomic, weak) UIViewController *mostRecentController;

@end

@implementation YPBaseNavigationController

#pragma mark - Override

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) return nil;
    self.screenShotList = [[NSMutableArray alloc] initWithCapacity:2];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotList addObject:[self capture]];
    
    if (self.viewControllers.count > 0) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self.view addGestureRecognizer:panGesture];
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    [self.screenShotList removeLastObject];
    return [super popViewControllerAnimated:animated];
}


#pragma mark - Private
- (void)panGesture:(UIPanGestureRecognizer *)panGesture
{
    if (self.viewControllers.count <= 1) return;
    
    CGPoint touchPoint = [panGesture locationInView:[UIApplication sharedApplication].keyWindow];
    
    if (panGesture.state == UIGestureRecognizerStateBegan) { // 开始拖动
        // 记录初始位置
        _isMoving = YES;
        _startTouchPoint = touchPoint;
        
        // 创建背景View
        UIView *bgContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.yp_width, self.view.yp_height)];
        self.bgContainer = bgContainer;
        [self.view.superview insertSubview:bgContainer belowSubview:self.view];
        self.bgContainer.hidden = NO;
        
        // 黑色遮罩
        UIView *blackMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.yp_width, self.view.yp_height)];
        self.blackMask = blackMask;
        blackMask.backgroundColor = YPBlackColor;
        [self.bgContainer addSubview:blackMask];
        
        // 释放之前的屏幕快照View
        if (self.lastScreenShotView) [self.lastScreenShotView removeFromSuperview];
        
        // 屏幕快照
        UIImage *lastScreenShot = [self.screenShotList lastObject];
        UIImageView *lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        self.lastScreenShotView = lastScreenShotView;
        [self.bgContainer insertSubview:self.lastScreenShotView belowSubview:self.blackMask];
        
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (touchPoint.x - _startTouchPoint.x > 100) {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:YPScreenW];
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                self.view.yp_x = 0;
                _isMoving = NO;
                // 拖动完毕后记得释放背景View
                if (self.bgContainer) [self.bgContainer removeFromSuperview];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.bgContainer.hidden = YES;
                // 拖动完毕后记得释放背景View
                if (self.bgContainer) [self.bgContainer removeFromSuperview];
            }];
        }
        return;
    } else if (panGesture.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.bgContainer.hidden = YES;
        }];
        return;
    }
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - _startTouchPoint.x];
    }
}

- (void)moveViewWithX:(float)x
{
    x = x > YPScreenW ? YPScreenW : x;
    x = x < 0 ? 0 : x;
    
    self.view.yp_x = x;
    
    float scale = (x / (YPScreenW * 20)) + 0.95;  // 0.05 - 375
    
    float alpha = 0.4 - (x / (YPScreenW * 2.5));
    
    self.lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    self.blackMask.alpha = alpha;
}

- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.yp_size, self.view.opaque, 0.0);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    if([_mostRecentController respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)])
    {
        return [(id<UINavigationControllerDelegate>)_mostRecentController navigationController:navigationController
                                                   interactionControllerForAnimationController:animationController];
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    SEL selector = @selector(navigationController:animationControllerForOperation:fromViewController:toViewController:);
    id<UIViewControllerAnimatedTransitioning> result = nil;
    if([fromVC respondsToSelector:selector])
    {
        result = [(id<UINavigationControllerDelegate>)fromVC navigationController:navigationController
                                                  animationControllerForOperation:operation
                                                               fromViewController:fromVC
                                                                 toViewController:toVC];
        if(result)
            self.mostRecentController = fromVC;
    }
    else if([toVC respondsToSelector:selector])
    {
        result = [(id<UINavigationControllerDelegate>)toVC navigationController:navigationController
                                                animationControllerForOperation:operation
                                                             fromViewController:fromVC
                                                               toViewController:toVC];
        if(result)
            self.mostRecentController = toVC;
    }
    
    return result;
}

@end






















