//
//  YPBaseTransitionsController.m
//  YPReusableController
//
//  Created by MichaelPPP on 16/1/27.
//  Copyright © 2016年 tyiti. All rights reserved.
//

#import "YPBaseTransitionsController.h"
#import "YPPushAnimator.h"
#import "YPPopAnimator.h"
#import "YPReusableControllerConst.h"

@interface YPBaseTransitionsController () <UINavigationControllerDelegate>

@end

@implementation YPBaseTransitionsController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if([animationController isKindOfClass:[YPBaseAnimator class]])
        return ((YPBaseAnimator *)animationController).interactiveTransitioning;
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if(operation == UINavigationControllerOperationPush)
    {
        YPPushAnimator *pushAnimator = [[YPPushAnimator alloc] init];
        return pushAnimator;
    }
    else if (operation == UINavigationControllerOperationPop)
    {
        YPPopAnimator *popAnimator = [[YPPopAnimator alloc] init];
        return popAnimator;
    }
    return nil;
}


@end
