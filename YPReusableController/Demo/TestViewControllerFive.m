//
//  TestViewControllerFive.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerFive.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerFive ()

@end

@implementation TestViewControllerFive

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第五个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
