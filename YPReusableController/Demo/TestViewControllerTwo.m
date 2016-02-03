//
//  TestViewControllerTwo.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerTwo.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerTwo ()

@end

@implementation TestViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第二个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
