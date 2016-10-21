//
//  TYPopupController.h
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYPopupAnimator.h"
#import "TYPopFadeAnimator.h"
#import "TYScaleFadeAnimator.h"
#import "TYDropDownAnimator.h"
#import "TYCoverVertiAnimator.h"

typedef NS_ENUM(NSUInteger, TYPopupStyle) {
    TYPopupStyleFade,
    TYPopupStyleScaleFade,
    TYPopupStyleDropDown,
    TYPopupStyleCoverVertical,
};

@interface TYPopupController : UIViewController

@property (nonatomic, strong, readonly) UIView *popView;

@property (nonatomic, strong, readonly) UIViewController *popViewController;

@property (nonatomic, assign, readonly) Class popAnimatorClass;

@property (nonatomic, assign, readonly) CGSize popViewSize;

@property (nonatomic, strong) UIView *backgroundView; // you set background or  coustom view to it

@property (nonatomic, assign) CGFloat popViewOriginY; // pop view top edge default center

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

@property (nonatomic, copy) void (^dismissComplete)(void); // dismiss controller completed block

#pragma mark - popViewController

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size;

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size popupStyle:(TYPopupStyle)popupStyle;

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size animatorClass:(Class)animatorClass;

#pragma mark - popView

+ (instancetype)popupControllerWithView:(UIView *)popView;

+ (instancetype)popupControllerWithView:(UIView *)popView popupStyle:(TYPopupStyle)popupStyle;

+ (instancetype)popupControllerWithView:(UIView *)popView animatorClass:(Class)animatorClass;

@end
