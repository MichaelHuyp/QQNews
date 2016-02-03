//
//  TestViewControllerSeven.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/31.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerSeven.h"
#import "YPReusableControllerConst.h"
@interface TestViewControllerSeven ()

@end

@implementation TestViewControllerSeven

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第七个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}


@end
