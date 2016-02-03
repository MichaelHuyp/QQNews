//
//  ViewController.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "ViewController.h"
#import "YPReusableController.h"
#import "TestViewControllerOne.h"
#import "TestViewControllerTwo.h"
#import "TestViewControllerThree.h"
#import "TestViewControllerFour.h"
#import "TestViewControllerFive.h"
#import "TestViewControllerSix.h"
#import "TestViewControllerSeven.h"
#import "TestViewController_10.h"
#import "TestViewController_11.h"
#import "TestViewControllerEight.h"
#import "TestViewControllerNine.h"
#import "TestViewControllerNine_12.h"
#import "TestViewControllerNine_13.h"
#import "YPSideController.h"
#import "YPChannelCustomController.h"
#import "YPBaseNavigationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *titleArray = [YPCacheTool channelTitleArray];
    
    if (!titleArray) return;
    
    TestViewControllerOne *oneVc = [[TestViewControllerOne alloc] init];
    TestViewControllerTwo *twoVc = [[TestViewControllerTwo alloc] init];
    TestViewControllerThree *threeVc = [[TestViewControllerThree alloc] init];
    TestViewControllerFour *fourVc = [[TestViewControllerFour alloc] init];
    TestViewControllerFive *fiveVc = [[TestViewControllerFive alloc] init];
    TestViewControllerSix *sixVc = [[TestViewControllerSix alloc] init];
    TestViewControllerSeven *sevenVc = [[TestViewControllerSeven alloc] init];
    TestViewControllerEight *vc_8 = [[TestViewControllerEight alloc] init];
    TestViewControllerNine *vc_9 = [[TestViewControllerNine alloc] init];
    TestViewController_10 *vc_10 = [[TestViewController_10 alloc] init];
    TestViewController_11 *vc_11 = [[TestViewController_11 alloc] init];
    TestViewControllerNine_12 *vc_12 = [[TestViewControllerNine_12 alloc] init];
    TestViewControllerNine_13 *vc_13 = [[TestViewControllerNine_13 alloc] init];
    
    NSArray *subViewController = @[oneVc,twoVc,threeVc,fourVc,fiveVc,sixVc,sevenVc,vc_8,vc_9,vc_10,vc_11,vc_12,vc_13];
    
    for (NSUInteger i = 0; i < subViewController.count; i++) {
        UIViewController *vc = subViewController[i];
        vc.yp_Title = titleArray[i];
    }
    

    YPReusableController *resusableVc = [[YPReusableController alloc] initWithParentViewController:self];
    resusableVc.subViewControllers = [subViewController copy];
    resusableVc.currentIndex = 0;
//    resusableVc.leftImage_normal = [UIImage imageNamed:@"setting_accountHeadIcon"];
    resusableVc.leftImage_normal = [UIImage imageNamed:@"icon_1"];
    resusableVc.rightImage_normal = [UIImage imageNamed:@"settings"];
    resusableVc.rightImage_normal = [UIImage imageNamed:@"settings-press"];
    
    [resusableVc setRightBtnTouchBlock:^{
        // 频道定制
        YPChannelCustomController *channelCustomVc = [[YPChannelCustomController alloc] init];
        [self.navigationController pushViewController:channelCustomVc animated:YES];
    }];
    
    [resusableVc setLeftBtnTouchBlock:^{
        // 开启侧滑功能
        [self.sideController presentLeftMenuViewController];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}


@end








































