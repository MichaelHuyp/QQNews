//
//  TestViewControllerFour.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/28.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "TestViewControllerFour.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerFour ()

@end

@implementation TestViewControllerFour

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第四个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}
@end
