//
//  YPSideController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/25.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPSideController.h"
#import "YPReusableControllerConst.h"
#import <objc/runtime.h>
#import "YPBaseNavigationController.h"

@interface UIViewController ()

@property (nonatomic, strong, readwrite) YPSideController *sideController;

@end

@interface YPSideController ()

@property (strong, readwrite, nonatomic) UIView *menuViewContainer;

@property (strong, readwrite, nonatomic) UIView *contentViewContainer;

@property (strong, readwrite, nonatomic) UIButton *contentButton;

@property (strong, readwrite, nonatomic) UIImageView *backgroundImageView;

@property (assign, readwrite, nonatomic) BOOL visible;

@property (assign, readwrite, nonatomic) BOOL leftMenuVisible;

/** 白色遮罩 */
@property (nonatomic, weak) UIView *whiteMask;

/** 右侧侧滑距离 */
@property (nonatomic, assign , readwrite) CGFloat sideDistance;

@end

@implementation YPSideController
{
    /** 记录开始拖拽的横坐标 */
    CGFloat _startPanX;
    /** 记录拖动的距离 */
    CGFloat _panDistance;
    /** 记录拖动总距离 */
    CGFloat _allDistance;
    /** 隐藏时的偏移量 */
    CGFloat _hideOffset;
}

#pragma mark - Override

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    [self commonInit];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // self
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // bgImageView
    self.backgroundImageView = ({
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        if (self.backgroundImage) imageView.image = self.backgroundImage;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView;
    });
    
    // contentBtn
    self.contentButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectNull];
        [btn addTarget:self action:@selector(hideMenuViewController) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.menuViewContainer];
    [self.view addSubview:self.contentViewContainer];
    
    self.menuViewContainer.frame = self.view.bounds;
    self.menuViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (self.leftMenuViewController) {
        [self addChildViewController:self.leftMenuViewController];
        self.leftMenuViewController.view.frame = self.view.bounds;
        self.leftMenuViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.menuViewContainer addSubview:self.leftMenuViewController.view];
        [self.leftMenuViewController didMoveToParentViewController:self];
    }
    
    self.contentViewContainer.frame = self.view.bounds;
    self.contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
    
    self.backgroundImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    
    if (self.panGestureEnabledWithHideMenu) { // 如果开启返回菜单时的拖动手势
        self.contentButton.multipleTouchEnabled = NO;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self.contentButton addGestureRecognizer:panGesture];
    }
    
}

#pragma mark - Public
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController leftMenuViewController:(UIViewController *)leftMenuViewController
{
    self = [self init];
    if (!self) return nil;
    _contentViewController = contentViewController;
    _leftMenuViewController = leftMenuViewController;
    return self;
}

- (void)presentLeftMenuViewController
{
    [self presentMenuViewContainerWithMenuViewController:self.leftMenuViewController];
    [self showLeftMenuViewController];
}

- (void)hideMenuViewController
{
    [self hideMenuViewControllerAnimated:YES];
}

#pragma mark - Private
- (void)commonInit
{
    _menuViewContainer = [[UIView alloc] init];
    
    _contentViewContainer = [[UIView alloc] init];
    
    _panGestureEnabledWithHideMenu = YES;
    
    if (iPHone4 || iPHone5) {
        _hideOffset = 66.0f;
    } else if (iPHone6) {
        _hideOffset = 77.0f;
    } else if (iPHone6Plus) {
        _hideOffset = 88.0f;
    }
    
    // 保存侧滑距离
    self.sideDistance = 1 - _hideOffset + YPScreenW * 0.5;
}

- (void)hideMenuViewControllerAnimated:(BOOL)animated
{
    UIViewController *visibleMenuViewController = self.leftMenuViewController;
    
    [visibleMenuViewController beginAppearanceTransition:NO animated:animated];
    
    if ([_myDelegate conformsToProtocol:@protocol(YPSideControllerDelegate)] && [_myDelegate respondsToSelector:@selector(sideVc:willHideMenuViewController:)]) {
        [_myDelegate sideVc:self willHideMenuViewController:self.leftMenuViewController];
    }
    
    [YPNotificationCenter postNotificationName:YPSideControllerWillHideMenuNotification object:nil];
    
    self.visible = NO;
    self.leftMenuVisible = NO;
    [self.contentButton removeFromSuperview];
    
    __typeof (self) __weak weakSelf = self;
    
    void (^animationBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf) return;
        strongSelf.contentViewContainer.transform = CGAffineTransformIdentity;
        strongSelf.contentViewContainer.frame = strongSelf.view.bounds;
        strongSelf.menuViewContainer.alpha = 0;
        strongSelf.contentViewContainer.alpha = 1;
        strongSelf.backgroundImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    };
    void (^completionBlock)(void) = ^{
        __typeof (weakSelf) __strong strongSelf = weakSelf;
        if (!strongSelf) return;
        [visibleMenuViewController endAppearanceTransition];
        if (!strongSelf.visible && [strongSelf.myDelegate conformsToProtocol:@protocol(YPSideControllerDelegate)] && [strongSelf.myDelegate respondsToSelector:@selector(sideVc:didHideMenuViewController:)]) {
            [strongSelf.myDelegate sideVc:strongSelf didHideMenuViewController:strongSelf.leftMenuViewController];
        }
        [YPNotificationCenter postNotificationName:YPSideControllerDidHideMenuNotification object:nil];
        if (self.whiteMask) [self.whiteMask removeFromSuperview];
    };
    if (animated) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [UIView animateWithDuration:0.35f animations:^{
            animationBlock();
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            completionBlock();
        }];
    } else {
        animationBlock();
        completionBlock();
    }
    [self statusBarNeedsAppearanceUpdate];
}

- (void)presentMenuViewContainerWithMenuViewController:(UIViewController *)menuViewController
{
    if ([_myDelegate conformsToProtocol:@protocol(YPSideControllerDelegate)] && [_myDelegate respondsToSelector:@selector(sideVc:willShowMenuViewController:)]) {
        [_myDelegate sideVc:self willShowMenuViewController:menuViewController];
    }
    [YPNotificationCenter postNotificationName:YPSideControllerWillShowMenuNotification object:nil];
}

- (void)showLeftMenuViewController
{
    if (!self.leftMenuViewController) return;
    // 开启过渡效果
    [self.leftMenuViewController beginAppearanceTransition:YES animated:YES];
    self.leftMenuViewController.view.hidden = NO;
    [self.view.window endEditing:YES];
    [self addContentButton];
    [self resetContentViewScale];
    
    [UIView animateWithDuration:0.35f animations:^{
        self.contentViewContainer.transform = CGAffineTransformIdentity;
        
        self.contentViewContainer.center = CGPointMake((UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) ? _hideOffset + CGRectGetWidth(self.view.frame) : _hideOffset + CGRectGetWidth(self.view.frame)), self.contentViewContainer.center.y);
        
        
        self.menuViewContainer.alpha = 1.0f;
        self.contentViewContainer.alpha = 1.0f;
        self.menuViewContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        [self.leftMenuViewController endAppearanceTransition];
        
        if (!self.visible && [_myDelegate conformsToProtocol:@protocol(YPSideControllerDelegate)] && [_myDelegate respondsToSelector:@selector(sideVc:didShowMenuViewController:)]) {
            [_myDelegate sideVc:self didShowMenuViewController:self.leftMenuViewController];
        }
        
        [YPNotificationCenter postNotificationName:YPSideControllerDidShowMenuNotification object:nil];
        
        self.visible = YES;
        self.leftMenuVisible = YES;
    }];
    
    [self statusBarNeedsAppearanceUpdate];
}

- (void)statusBarNeedsAppearanceUpdate
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [UIView animateWithDuration:0.3f animations:^{
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }];
    }
}

/**
 *  添加遮罩按钮
 */
- (void)addContentButton
{
    if (self.contentButton.superview) return;
    
    self.contentButton.autoresizingMask = UIViewAutoresizingNone;
    self.contentButton.frame = _contentViewContainer.bounds;
    self.contentButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_contentViewContainer addSubview:self.contentButton];
}

/**
 *  重置视图伸缩度
 */
- (void)resetContentViewScale
{
    CGAffineTransform t = _contentViewContainer.transform;
    CGFloat scale = sqrt(t.a * t.a + t.c * t.c);
    CGRect frame = _contentViewContainer.frame;
    _contentViewContainer.transform = CGAffineTransformIdentity;
    _contentViewContainer.transform = CGAffineTransformMakeScale(scale, scale);
    _contentViewContainer.frame = frame;
}


/**
 *  添加手势
 */
- (void)panGesture:(UIPanGestureRecognizer *)panGesture
{
    if (self.contentViewContainer.yp_x <= 0) self.contentViewContainer.yp_x = 0;
    
    // 如果没有开启手势 直接return
    if (!self.panGestureEnabledWithHideMenu) return;
    
    CGPoint touchPoint = [panGesture translationInView:panGesture.view];
    
    if (panGesture.state == UIGestureRecognizerStateBegan)
    {
        // 记录开始拖拽的位置
        _startPanX = touchPoint.x;
        _allDistance = _hideOffset + CGRectGetWidth(self.view.frame) * 0.5;
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged)
    {
        // 记录拖动距离
        _panDistance = touchPoint.x - _startPanX;
        if (_panDistance >= 0 || self.contentViewContainer.yp_x <= 0) return;
        self.contentViewContainer.transform = CGAffineTransformMakeTranslation(_panDistance, 0);
        if ([self.contentViewController isKindOfClass:[YPBaseNavigationController class]]) {
            YPBaseNavigationController *nav = (YPBaseNavigationController *)self.contentViewController;
            // 创建遮罩界面
            if (!self.whiteMask) {
                UIView *whiteMask = [[UIView alloc] init];
                self.whiteMask = whiteMask;
                whiteMask.backgroundColor = YPColor_RGB(250, 250, 250);
                whiteMask.frame = CGRectMake(0, 0, YPScreenW, 20);
                [nav.view addSubview:whiteMask];
                [nav.view bringSubviewToFront:whiteMask];
            }
            CGFloat progress = 1 - (self.contentViewContainer.yp_x / _allDistance);
            self.whiteMask.alpha = progress;
        }
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled)
    {
        [self adjustPosition];
    }
}

- (void)adjustPosition
{
    (_panDistance < -66) ? [self hideMenuViewController] : [self presentLeftMenuViewController];
    if (self.contentViewContainer.yp_x == _allDistance) self.whiteMask.alpha = 0;
}


@end


@implementation UIViewController (YPSideControllerExtension)

- (YPSideController *)sideController
{
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[YPSideController class]]) {
            return (YPSideController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end

NSString *const YPSideControllerWillShowMenuNotification = @"YPSideControllerWillShowMenuNotification";
NSString *const YPSideControllerDidShowMenuNotification = @"YPSideControllerDidShowMenuNotification";
NSString *const YPSideControllerWillHideMenuNotification = @"YPSideControllerWillHideMenuNotification";
NSString *const YPSideControllerDidHideMenuNotification = @"YPSideControllerDidHideMenuNotification";
























