//
//  TYSideLeftInAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 2017/9/5.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYSideInOutAnimator.h"
#import "TYPopupController.h"

NS_INLINE void addPopupViewLayoutConstraint(TYPopupController *popupControler,BOOL isLeft) {
    UIView *view = popupControler.view;
    UIView *popView = popupControler.popView;
    popView.translatesAutoresizingMaskIntoConstraints = NO;
    [popView addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:popupControler.popViewSize.width]];
    if (popupControler.popViewSize.height > 0 && !popupControler.popupViewHeightAlwaysEqualToSuperView) {
        [popView addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:popupControler.popViewSize.height]];
        CGFloat centerYOffset = popupControler.popViewOriginY == 0 ? 0 :popupControler.popViewOriginY - (CGRectGetHeight(popupControler.view.frame) - popupControler.popViewSize.height)/2;
        [view addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:centerYOffset]];
    }else {
        [view addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }
    if (isLeft) {
        [view addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    }else {
         [view addConstraint:[NSLayoutConstraint constraintWithItem:popView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    }
}

@implementation TYSideLeftInAnimator

+ (void)addPopupViewLayoutConstraint:(TYPopupController *)popupControler {
    addPopupViewLayoutConstraint(popupControler, YES);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    
    popController.popView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(popController.popView.frame), 0);
    
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
        popController.popView.transform = CGAffineTransformMakeTranslation(-CGRectGetWidth(popController.popView.frame),0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end


@implementation TYSideRightInAnimator

+ (void)addPopupViewLayoutConstraint:(TYPopupController *)popupControler {
    addPopupViewLayoutConstraint(popupControler, NO);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TYPopupController *popController = (TYPopupController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    popController.backgroundView.alpha = 0.0;
    
    popController.popView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(popController.popView.frame), 0);
    
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
        popController.popView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(popController.popView.frame),0);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
