//
//  TestViewControllerEight.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/22.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TestViewControllerEight.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerEight ()

@end

@implementation TestViewControllerEight

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第八个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}
@end
