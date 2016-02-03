//
//  YPPopAnimator.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPPopAnimator.h"
#import "YPReusableControllerConst.h"

@interface YPPopAnimator ()

@property (nonatomic, weak) UIView *blackMask;

@end

@implementation YPPopAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 目标控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 控制器栈
    UIView *container = [transitionContext containerView];
    
    [container insertSubview:toVc.view belowSubview:fromVc.view];
    
    UIView *blackMask = [[UIView alloc] init];
    self.blackMask = blackMask;
    blackMask.backgroundColor = YPBlackColor;
    blackMask.frame = CGRectMake(0, 0, YPScreenW, YPScreenH);
    [container insertSubview:self.blackMask aboveSubview:toVc.view];
    
    float scale = 0.95;
    toVc.view.transform = CGAffineTransformMakeScale(scale, scale);
    self.blackMask.alpha = 0.4;
    fromVc.view.yp_x = 0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        // 动画效果
        toVc.view.transform = CGAffineTransformIdentity;
        fromVc.view.yp_x = YPScreenW;
        weakSelf.blackMask.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.blackMask removeFromSuperview];
        [fromVc.view removeFromSuperview];
        if (transitionContext.transitionWasCancelled) { // 如果遇到未知取消操作恢复栈结构
            [container addSubview:fromVc.view];
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
