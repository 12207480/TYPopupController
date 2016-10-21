//
//  TYPopFadeAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYPopFadeAnimator.h"
#import "TYPopupController.h"

@implementation TYPopFadeAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transition == TYPopupTransitionPresent) {
        return 0.45;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    popController.popView.alpha = 0.0;
    popController.popView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:popController.view];
    
    [UIView animateWithDuration:0.25 animations:^{
        popController.backgroundView.alpha = 1.0;
        popController.popView.alpha = 1.0;
        popController.popView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            popController.popView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }];
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    popController.popView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.25 animations:^{
        popController.backgroundView.alpha = 0.0;
        popController.popView.alpha = 0.0;
        popController.popView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
