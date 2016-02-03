//
//  UIScrollView+YPAdd.h
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YPAdd)

@property (assign, nonatomic) CGFloat yp_insetT;
@property (assign, nonatomic) CGFloat yp_insetB;
@property (assign, nonatomic) CGFloat yp_insetL;
@property (assign, nonatomic) CGFloat yp_insetR;

@property (assign, nonatomic) CGFloat yp_offsetX;
@property (assign, nonatomic) CGFloat yp_offsetY;

@property (assign, nonatomic) CGFloat yp_contentW;
@property (assign, nonatomic) CGFloat yp_contentH;

@end
