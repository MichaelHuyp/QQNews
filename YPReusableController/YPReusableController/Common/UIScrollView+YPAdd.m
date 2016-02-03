//
//  UIScrollView+YPAdd.m
//  YPReusableController
//
//  Created by MichaelPPP on 15/12/29.
//  Copyright (c) 2015年 tyiti. All rights reserved.
//

#import "UIScrollView+YPAdd.h"

@implementation UIScrollView (YPAdd)

- (void)setYp_insetT:(CGFloat)yp_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = yp_insetT;
    self.contentInset = inset;
}

- (CGFloat)yp_insetT
{
    return self.contentInset.top;
}

- (void)setYp_insetB:(CGFloat)yp_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = yp_insetB;
    self.contentInset = inset;
}

- (CGFloat)yp_insetB
{
    return self.contentInset.bottom;
}

- (void)setYp_insetL:(CGFloat)yp_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = yp_insetL;
    self.contentInset = inset;
}

- (CGFloat)yp_insetL
{
    return self.contentInset.left;
}

- (void)setYp_insetR:(CGFloat)yp_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = yp_insetR;
    self.contentInset = inset;
}

- (CGFloat)yp_insetR
{
    return self.contentInset.right;
}

- (void)setYp_offsetX:(CGFloat)yp_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = yp_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)yp_offsetX
{
    return self.contentOffset.x;
}

- (void)setYp_offsetY:(CGFloat)yp_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = yp_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)yp_offsetY
{
    return self.contentOffset.y;
}

- (void)setYp_contentW:(CGFloat)yp_contentW
{
    CGSize size = self.contentSize;
    size.width = yp_contentW;
    self.contentSize = size;
}

- (CGFloat)yp_contentW
{
    return self.contentSize.width;
}

- (void)setYp_contentH:(CGFloat)yp_contentH
{
    CGSize size = self.contentSize;
    size.height = yp_contentH;
    self.contentSize = size;
}

- (CGFloat)yp_contentH
{
    return self.contentSize.height;
}

@end
