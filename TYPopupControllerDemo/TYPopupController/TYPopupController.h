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
#import "TYDropDownAnimator.h"
#import "TYCoverVertiAnimator.h"
#import "TYSideInOutAnimator.h"

typedef NS_ENUM(NSUInteger, TYPopupStyle) {
    TYPopupStyleFade,
    TYPopupStyleScaleFade,
    TYPopupStyleDropDown,
    TYPopupStyleCoverVertical,
    TYPopupStyleSideLeftInOut,
    TYPopupStyleSideRightInOut,
};

@interface TYPopupController : UIViewController

@property (nonatomic, strong, readonly) UIView *popView;

@property (nonatomic, strong, readonly) UIViewController *popViewController;

@property (nonatomic, assign, readonly) Class popAnimatorClass;

@property (nonatomic, assign, readonly) CGSize popViewSize; // pop view size if size‘s height = 0 is equal to superView height
@property (nonatomic, assign) BOOL popupViewHeightAlwaysEqualToSuperView;// default NO

@property (nonatomic, strong) UIView *backgroundView; // you set background or  coustom view to it

@property (nonatomic, assign) CGFloat popViewOriginY; // pop view top edge default center

@property (nonatomic, assign) BOOL backgoundTapDismissEnable;  // default NO

@property (nonatomic, assign) BOOL adjustKeyboardShowHide; // auto adjust keyboard show or hide default NO

@property (nonatomic, copy) void (^dismissComplete)(void); // dismiss controller completed block

#pragma mark - popViewController

// if size‘s height = 0 is equal to superView height
+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)popViewSize;

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)popViewSize popupStyle:(TYPopupStyle)popupStyle;

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)popViewSize animatorClass:(Class)animatorClass;

#pragma mark - popView
// if popView size‘s height = 0 is equal to superView height
+ (instancetype)popupControllerWithView:(UIView *)popView;

+ (instancetype)popupControllerWithView:(UIView *)popView popupStyle:(TYPopupStyle)popupStyle;

+ (instancetype)popupControllerWithView:(UIView *)popView animatorClass:(Class)animatorClass;

#pragma mark - dismiss

- (void)dismissViewControllerAnimated:(BOOL)animated;

@end


#pragma mark - popupController category

@interface UIView (TYPopupController)

- (TYPopupController *)popupController; // after super call viewdidLoad or addsubView, have value

@end
