//
//  UIView+YPAdd.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "UIView+YPAdd.h"

@implementation UIView (YPAdd)
- (UIViewController*)viewController
{
    for (UIView* view = self; view; view = view.superview) {
        UIResponder* nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setYp_x:(CGFloat)yp_x
{
    CGRect frame = self.frame;
    frame.origin.x = yp_x;
    self.frame = frame;
}

- (CGFloat)yp_x
{
    return self.frame.origin.x;
}

- (void)setYp_y:(CGFloat)yp_y
{
    CGRect frame = self.frame;
    frame.origin.y = yp_y;
    self.frame = frame;
}

- (CGFloat)yp_y
{
    return self.frame.origin.y;
}

- (CGFloat)yp_left
{
    return self.frame.origin.x;
}

- (void)setYp_left:(CGFloat)yp_left
{
    CGRect frame = self.frame;
    frame.origin.x = yp_left;
    self.frame = frame;
}

- (CGFloat)yp_top
{
    return self.frame.origin.y;
}

- (void)setYp_top:(CGFloat)yp_top
{
    CGRect frame = self.frame;
    frame.origin.y = yp_top;
    self.frame = frame;
}

- (CGFloat)yp_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYp_right:(CGFloat)yp_right
{
    CGRect frame = self.frame;
    frame.origin.x = yp_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)yp_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYp_bottom:(CGFloat)yp_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = yp_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)yp_width
{
    return self.frame.size.width;
}

- (void)setYp_width:(CGFloat)yp_width
{
    CGRect frame = self.frame;
    frame.size.width = yp_width;
    self.frame = frame;
}

- (CGFloat)yp_height
{
    return self.frame.size.height;
}

- (void)setYp_height:(CGFloat)yp_height
{
    CGRect frame = self.frame;
    frame.size.height = yp_height;
    self.frame = frame;
}

- (CGFloat)yp_centerX
{
    return self.center.x;
}

- (void)setYp_centerX:(CGFloat)yp_centerX
{
    self.center = CGPointMake(yp_centerX, self.center.y);
}

- (CGFloat)yp_centerY
{
    return self.center.y;
}

- (void)setYp_centerY:(CGFloat)yp_centerY
{
    self.center = CGPointMake(self.center.x, yp_centerY);
}

- (CGPoint)yp_origin
{
    return self.frame.origin;
}

- (void)setYp_origin:(CGPoint)yp_origin
{
    CGRect frame = self.frame;
    frame.origin = yp_origin;
    self.frame = frame;
}

- (CGSize)yp_size
{
    return self.frame.size;
}

- (void)setYp_size:(CGSize)yp_size
{
    CGRect frame = self.frame;
    frame.size = yp_size;
    self.frame = frame;
}

- (void)removeAllSubviews
{
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
@end
