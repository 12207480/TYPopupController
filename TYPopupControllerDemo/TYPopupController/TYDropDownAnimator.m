//
//  TYDropDownAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYDropDownAnimator.h"
#import "TYPopupController.h"

@implementation TYDropDownAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return 0.5;
    }
    return 0.25;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    
    popController.popView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetMaxY(popController.popView.frame));
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:popController.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.65 initialSpringVelocity:0.5 options:0 animations:^{
        
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
        popController.popView.alpha = 0.0;
        popController.popView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
