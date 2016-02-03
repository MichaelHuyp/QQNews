//
//  YPBaseAnimator.h
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YPBaseAnimator : NSObject

@property (nonatomic, assign) NSTimeInterval duration;

@property (nonatomic, strong) id<UIViewControllerInteractiveTransitioning> interactiveTransitioning;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerInteractiveTransitioning>)transitionContext;

@end
