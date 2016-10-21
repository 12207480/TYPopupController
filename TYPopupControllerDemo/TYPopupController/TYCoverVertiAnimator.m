//
//  TYCoverVertiAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYCoverVertiAnimator.h"
#import "TYPopupController.h"

@implementation TYCoverVertiAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    
    popController.popView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(popController.view.frame) - CGRectGetMinY(popController.popView.frame));
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:popController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        popController.backgroundView.alpha = 1.0;
        popController.popView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        popController.backgroundView.alpha = 0.0;
        popController.popView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(popController.view.frame) - CGRectGetMinY(popController.popView.frame));
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
