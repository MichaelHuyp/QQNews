//
//  AppDelegate.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "AppDelegate.h"
#import "YPSideController.h"
#import "YPLeftMenuController.h"
#import "YPReusableControllerConst.h"
#import "ViewController.h"
#import "YPBaseNavigationController.h"

@interface AppDelegate () <YPSideControllerDelegate,UINavigationControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *channelTitleArray = [YPCacheTool channelTitleArray];
    
    if (!channelTitleArray) {
        NSArray *titleArray = @[@"要闻",@"体育",@"辽宁",@"娱乐",@"北京",@"社会",@"视频",@"教育",@"游戏",@"理财",@"股票",@"家居",@"财经"];
        [YPCacheTool saveChannelTitleArray:titleArray];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:YPScreenBounds];
    [self.window makeKeyAndVisible];
    YPBaseNavigationController *navVc = [[YPBaseNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    YPLeftMenuController *leftVc = [[YPLeftMenuController alloc] init];
    YPSideController *sideVc = [[YPSideController alloc] initWithContentViewController:navVc leftMenuViewController:leftVc];
    sideVc.backgroundImage = [UIImage imageNamed:@"mine_sidebar_background"];
    sideVc.myDelegate = self;
    self.window.rootViewController = sideVc;
    
    return YES;
}

- (void)sideVc:(YPSideController *)sideVc willShowMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (void)sideVc:(YPSideController *)sideVc willHideMenuViewController:(UIViewController *)menuViewController
{
    [UIView animateWithDuration:0.35f animations:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
}


@end
