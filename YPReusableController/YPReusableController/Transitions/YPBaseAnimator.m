//
//  YPBaseAnimator.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseAnimator.h"

@implementation YPBaseAnimator

#pragma mark - Override
- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    _duration = 0.35;
    return self;
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerInteractiveTransitioning>)transitionContext
{
    return _duration;
}

@end
