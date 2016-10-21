//
//  TYPopupAnimator.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYPopupAnimator.h"
#import "TYPopupController.h"

@interface TYPopupAnimator ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) TYPopupTransition transition;

@end

@implementation TYPopupAnimator

- (instancetype)initWithTransition:(TYPopupTransition)transition
{
    if (self = [super init]) {
        _transition = transition;
    }
    return self;
}

+ (instancetype)popupAnimatorTransition:(TYPopupTransition)transition
{
    return [[self alloc]initWithTransition:transition];
}

- (BOOL)isPresenting
{
    return _transition == TYPopupTransitionPresent;
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        [self presentAnimateTransition:transitionContext];
    }else {
        [self dismissAnimateTransition:transitionContext];
    }
}

- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
}

@end
