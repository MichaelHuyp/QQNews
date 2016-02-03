//
//  YPSideController.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/25.
//  Copyright © 2016年 tyiti. All rights reserved.
//  侧滑根控制器

#import <UIKit/UIKit.h>

@protocol YPSideControllerDelegate;

@interface YPSideController : UIViewController

/** 主控制器 */
@property (nonatomic, strong) UIViewController *contentViewController;

/** 左侧菜单控制器 */
@property (nonatomic, strong) UIViewController *leftMenuViewController;

/** 背景图片 */
@property (nonatomic, strong) UIImage *backgroundImage;

/** 代理 */
@property (nonatomic, assign) id<YPSideControllerDelegate> myDelegate;

/** 是否开启在隐藏菜单时的拖拽手势 */
@property (nonatomic, assign) BOOL panGestureEnabledWithHideMenu;

/** 右侧侧滑距离 */
@property (nonatomic, assign , readonly) CGFloat sideDistance;

/** 初始化方法 */
- (instancetype)initWithContentViewController:(UIViewController *)contentViewController
             leftMenuViewController:(UIViewController *)leftMenuViewController;

/** 弹出左侧菜单控制器 */
- (void)presentLeftMenuViewController;

/** 收回菜单控制器 */
- (void)hideMenuViewController;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

@interface UIViewController(YPSideControllerExtension)

@property (nonatomic, strong, readonly) YPSideController *sideController;

@end

@protocol YPSideControllerDelegate <NSObject>

@optional
- (void)sideVc:(YPSideController *)sideVc willShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideVc:(YPSideController *)sideVc didShowMenuViewController:(UIViewController *)menuViewController;
- (void)sideVc:(YPSideController *)sideVc willHideMenuViewController:(UIViewController *)menuViewController;
- (void)sideVc:(YPSideController *)sideVc didHideMenuViewController:(UIViewController *)menuViewController;
@end

UIKIT_EXTERN NSString *const YPSideControllerWillShowMenuNotification;
UIKIT_EXTERN NSString *const YPSideControllerDidShowMenuNotification;
UIKIT_EXTERN NSString *const YPSideControllerWillHideMenuNotification;
UIKIT_EXTERN NSString *const YPSideControllerDidHideMenuNotification;





