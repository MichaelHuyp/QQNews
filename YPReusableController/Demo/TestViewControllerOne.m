//
//  TestViewControllerOne.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerOne.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerOne ()

@end

@implementation TestViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第一个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}


@end
