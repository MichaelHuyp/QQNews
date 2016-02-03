//
//  TestViewControllerThree.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerThree.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerThree ()

@end

@implementation TestViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第三个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
