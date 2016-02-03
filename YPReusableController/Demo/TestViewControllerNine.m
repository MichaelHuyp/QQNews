//
//  TestViewControllerNine.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/22.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "TestViewControllerNine.h"
#import "YPReusableControllerConst.h"

@interface TestViewControllerNine ()

@end

@implementation TestViewControllerNine

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPLog(@"第九个控制器加载完毕");
    
    self.view.backgroundColor = YPRandomColor_RGB;
}

@end
