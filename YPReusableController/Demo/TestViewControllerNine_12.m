//
//  TestViewControllerNine_12.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/22.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TestViewControllerNine_12.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerNine_12 ()

@end

@implementation TestViewControllerNine_12

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第十二个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
