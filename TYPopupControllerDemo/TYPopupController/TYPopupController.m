//
//  TYPopupController.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "TYPopupController.h"

@interface TYPopupController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *popView;

@property (nonatomic, strong) UIViewController *popViewController;

@property (nonatomic, assign) CGSize popViewSize;

@property (nonatomic, assign) Class popAnimatorClass;

@property (nonatomic, weak) UITapGestureRecognizer *singleTap;

@property (nonatomic, strong) NSLayoutConstraint *popViewCenterYConstraint;

@end

@implementation TYPopupController

@synthesize backgroundView = _backgroundView;

#pragma mark - init

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configureController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configureController];
    }
    return self;
}

#pragma mark -  popViewController

- (instancetype)initWithPopViewController:(UIViewController *)viewController size:(CGSize)size animatorClass:(Class)animatorClass
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _popViewController = viewController;
        _popViewSize = size;
        _popAnimatorClass = animatorClass;
    }
    return self;
}

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size
{
    return [self popupControllerWithController:popViewController size:size popupStyle:TYPopupStyleFade];
}

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size animatorClass:(Class)animatorClass
{
    return [[self alloc]initWithPopViewController:popViewController size:size animatorClass:animatorClass];
}

+ (instancetype)popupControllerWithController:(UIViewController *)popViewController size:(CGSize)size popupStyle:(TYPopupStyle)popupStyle
{
    return [self popupControllerWithController:popViewController size:size animatorClass:[self animatorClassFromPopupStyle:popupStyle]];
}

#pragma mark - popView

- (instancetype)initWithView:(UIView *)popView animatorClass:(Class)animatorClass
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _popView = popView;
        _popViewSize = popView.frame.size;
        _popAnimatorClass = animatorClass;
    }
    return self;
}

+ (instancetype)popupControllerWithView:(UIView *)popView animatorClass:(Class)animatorClass
{
    return [[self alloc]initWithView:popView animatorClass:animatorClass];
}

+ (instancetype)popupControllerWithView:(UIView *)popView
{
    return [self popupControllerWithView:popView popupStyle:TYPopupStyleFade];
}

+ (instancetype)popupControllerWithView:(UIView *)popView popupStyle:(TYPopupStyle)popupStyle
{
    return [self popupControllerWithView:popView animatorClass:[self animatorClassFromPopupStyle:popupStyle]];
}

- (void)configureController
{
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    
    _popViewOriginY = 0;
    _backgoundTapDismissEnable = YES;
}

+ (Class)animatorClassFromPopupStyle:(TYPopupStyle)popupStyle
{
    switch (popupStyle) {
        case TYPopupStyleFade:
            return [TYPopFadeAnimator class];
        case TYPopupStyleScaleFade:
            return [TYScaleFadeAnimator class];
        case TYPopupStyleDropDown:
            return [TYDropDownAnimator class];
        case TYPopupStyleCoverVertical:
            return [TYCoverVertiAnimator class];
        default:
            return nil;
    }
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];

    [self addBackgroundView];
    
    [self addSingleTapGesture];
    
    [self addPopViewOrController];
    
    [self.view layoutIfNeeded];
}

- (void)addBackgroundView
{
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view insertSubview:self.backgroundView atIndex:0];
    
    [self addConstraintWithView:self.backgroundView edgeInset:UIEdgeInsetsZero];
}

- (void)addSingleTapGesture
{
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.enabled = _backgoundTapDismissEnable;
    
    [self.backgroundView addGestureRecognizer:singleTap];
    _singleTap = singleTap;
}

 -(void)addPopViewOrController
{
    if (_popViewController) {
        [self addPopViewController];
    }else if(_popView) {
        [self addPopView];
    }
    [self addPopViewConstraint];
}

- (void)addPopViewController
{
    [self addChildViewController:_popViewController];
    [self.view addSubview:_popViewController.view];
    _popView = _popViewController.view;
     [_popViewController didMoveToParentViewController:self];
}

- (void)addPopView
{
    [self.view addSubview:_popView];
}

- (void)addPopViewConstraint
{
    NSAssert(_popView,@"popViewController and popView are nil!");
    NSAssert(!CGSizeEqualToSize(_popViewSize, CGSizeZero), @"popView size can't zero!");
    _popView.translatesAutoresizingMaskIntoConstraints = NO;
    // size
    [self addConstarintWithView:_popView size:_popViewSize];
    
    // center X
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_popView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    // topEdgeY
    _popViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:_popView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:[self popViewCenterYOffset]];
    [self.view addConstraint:_popViewCenterYConstraint];
}

- (void)setPopViewOriginY:(CGFloat)popViewOriginY
{
    _popViewOriginY = popViewOriginY;
    
    if (_popViewCenterYConstraint) {
        _popViewCenterYConstraint.constant = [self popViewCenterYOffset];
    }
}

#pragma mark - geter setter

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return _backgroundView;
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    if (!_backgroundView || !_backgroundView.superview) {
        _backgroundView = backgroundView;
    } else if (_backgroundView != backgroundView) {
        [self addNewBackgroundView:backgroundView];
    }
}

- (void)addNewBackgroundView:(UIView *)backgroundView
{
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    backgroundView.alpha = 0;
    [self.view insertSubview:backgroundView aboveSubview:_backgroundView];
    [self addConstraintWithView:backgroundView edgeInset:UIEdgeInsetsZero];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        [self addSingleTapGesture];
    }];
}

- (CGFloat)popViewCenterYOffset
{
    return _popViewOriginY == 0 ? 0 :_popViewOriginY - (CGRectGetHeight(self.view.frame) - _popViewSize.height)/2;
}

- (void)setBackgoundTapDismissEnable:(BOOL)backgoundTapDismissEnable
{
    _backgoundTapDismissEnable = backgoundTapDismissEnable;
    _singleTap.enabled = backgoundTapDismissEnable;
}

#pragma mark - public

- (void)dismissViewControllerAnimated:(BOOL)animated
{
    [self dismissViewControllerAnimated:animated completion:_dismissComplete];
}

#pragma mark - action

- (void)singleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES];
}

#pragma mark - auto layout

// edgeInset Constarint
- (void)addConstraintWithView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInset.top]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInset.left]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:edgeInset.right]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:edgeInset.bottom]];
}

// size Constarint
- (void)addConstarintWithView:(UIView *)view size:(CGSize)size
{
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.width]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:size.height]];
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return _popAnimatorClass ? [_popAnimatorClass popupAnimatorTransition:TYPopupTransitionPresent] : nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _popAnimatorClass ? [_popAnimatorClass popupAnimatorTransition:TYPopupTransitionDismiss] : nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@ %s",NSStringFromClass([self class]), __FUNCTION__);
}

@end
