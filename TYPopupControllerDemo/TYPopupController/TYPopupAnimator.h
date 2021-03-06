//
//  TYPopupAnimator.h
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TYPopupTransition){
    TYPopupTransitionPresent,
    TYPopupTransitionDismiss,
};

@class TYPopupController;

@protocol TYPopupAnimator <NSObject>
@optional
+ (void)addPopupViewLayoutConstraint:(TYPopupController *)popupControler;

@required
// transiton time
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;

// present transiton
- (void)presentAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

// dismiss transiton
- (void)dismissAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

@interface TYPopupAnimator : NSObject<TYPopupAnimator>

@property (nonatomic, assign, readonly) TYPopupTransition transition;

@property (nonatomic, assign, readonly) BOOL isPresenting; // present or dismiss

+ (instancetype)popupAnimatorTransition:(TYPopupTransition)transition;

@end
