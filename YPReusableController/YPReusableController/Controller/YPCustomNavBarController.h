//
//  YPCustomNavBarController.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/26.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPReusableControllerConst.h"
#import "YPBaseTransitionsController.h"

typedef void(^YPCustomNavBarControllerNormalBlock)(void);

@interface YPCustomNavBarController : YPBaseTransitionsController

/**
 *  固定样式
 *
 *  @param title 标题
 */
- (void)createNavBarWithTitle:(NSString *)title;

- (void)createNavBarWithTitle:(NSString *)title rightAction:(YPCustomNavBarControllerNormalBlock)actionBlock;

@end
