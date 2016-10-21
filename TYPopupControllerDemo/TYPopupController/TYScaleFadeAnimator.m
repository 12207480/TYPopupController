//
//  TYScaleFadeAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYScaleFadeAnimator.h"
#import "TYPopupController.h"

@implementation TYScaleFadeAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    
    popController.popView.alpha = 0.0;
    popController.popView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:popController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        popController.backgroundView.alpha = 1.0;
        popController.popView.alpha = 1.0;
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
        popController.popView.alpha = 0.0;
        popController.popView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
