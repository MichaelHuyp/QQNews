//
//  UIView+YPAdd.h
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YPAdd)

@property (nonatomic, readonly) UIViewController *viewController;

@property (nonatomic) CGFloat yp_x;
@property (nonatomic) CGFloat yp_y;
@property (nonatomic) CGFloat yp_left;
@property (nonatomic) CGFloat yp_top;
@property (nonatomic) CGFloat yp_right;
@property (nonatomic) CGFloat yp_bottom;
@property (nonatomic) CGFloat yp_width;
@property (nonatomic) CGFloat yp_height;
@property (nonatomic) CGFloat yp_centerX;
@property (nonatomic) CGFloat yp_centerY;
@property (nonatomic) CGPoint yp_origin;
@property (nonatomic) CGSize yp_size;

- (void)removeAllSubviews;


@end
