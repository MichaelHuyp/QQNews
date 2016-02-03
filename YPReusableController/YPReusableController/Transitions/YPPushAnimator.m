//
//  YPPushAnimator.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPPushAnimator.h"
#import "YPReusableControllerConst.h"

@interface YPPushAnimator ()

@property (nonatomic, weak) UIView *blackMask;

@end

@implementation YPPushAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 目标控制器
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 源控制器
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 控制器栈
    UIView *container = [transitionContext containerView];
    
    // 入栈
    [container addSubview:toVc.view];
    
    toVc.view.yp_x = YPScreenW;
    
    UIView *blackMask = [[UIView alloc] init];
    self.blackMask = blackMask;
    blackMask.backgroundColor = YPBlackColor;
    blackMask.frame = CGRectMake(0, 0, YPScreenW, YPScreenH);
    blackMask.alpha = 0;
    [container insertSubview:self.blackMask aboveSubview:fromVc.view];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateKeyframesWithDuration:self.duration delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        // 动画效果
        float scale = 0.95;
        fromVc.view.transform = CGAffineTransformMakeScale(scale, scale);
        toVc.view.yp_x = 0;
        weakSelf.blackMask.alpha = 0.4;
    } completion:^(BOOL finished) {
        fromVc.view.transform = CGAffineTransformIdentity;
        [weakSelf.blackMask removeFromSuperview];
        [container addSubview:fromVc.view];
        [container addSubview:toVc.view];
        if (transitionContext.transitionWasCancelled) { // 如果遇到未知取消操作恢复栈结构
            [toVc.view removeFromSuperview];
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        
    }];
    
    
}



@end

























