//
//  PopViewController.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "PopViewController.h"
#import "LoginView.h"
#import "TYPopupController.h"

@interface PopViewController ()
@property (nonatomic, weak) LoginView *logView;
@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor redColor];
    
    [self addLoginView];
}

- (void)addLoginView
{
    LoginView *logView = [LoginView createViewFromNib];
    [logView.cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [logView.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logView];
    _logView = logView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _logView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%s",__FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - action

- (void)cancleAction:(UIButton *)button
{
    [_logView endEditing:YES];
}

- (void)loginAction:(UIButton *)button
{
    [_logView endEditing:YES];
    [_logView.popupController dismissViewControllerAnimated:YES];
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
