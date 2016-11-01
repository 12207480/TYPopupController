//
//  ViewController.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/20.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "ViewController.h"
#import "TYPopupController.h"
#import "PopViewController.h"
#import "LoginView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)popupControllerAction:(id)sender {
    TYPopupController *popupController = [TYPopupController popupControllerWithController:[PopViewController new] size:CGSizeMake(300, 250) popupStyle:TYPopupStyleDropDown];
    popupController.backgoundTapDismissEnable = YES;
    popupController.adjustKeyboardShowHide = YES;
    [self presentViewController:popupController animated:YES completion:nil];
}

- (IBAction)popupViewAction:(id)sender {
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    TYPopupController *popupController = [TYPopupController popupControllerWithView:popView];
    popupController.backgoundTapDismissEnable = YES;
    [self presentViewController:popupController animated:YES completion:nil];
}
- (IBAction)loginViewAction:(id)sender {
    LoginView *logView = [LoginView createViewFromNib];
    [logView.cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    [logView.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    TYPopupController *popupController = [TYPopupController popupControllerWithView:logView];
    popupController.adjustKeyboardShowHide = YES;
    [self presentViewController:popupController animated:YES completion:nil];

}

- (IBAction)blurViewAction:(id)sender {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        LoginView *logView = [LoginView createViewFromNib];
        [logView.cancleButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
        [logView.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        TYPopupController *popupController = [TYPopupController popupControllerWithView:logView];
        popupController.adjustKeyboardShowHide = YES;
        popupController.backgroundView = visualEffectView;
        [self presentViewController:popupController animated:YES completion:nil];
    }
}

#pragma mark - action

- (void)cancleAction:(UIButton *)button
{
    [button.superview endEditing:YES];
}

- (void)loginAction:(UIButton *)button
{
    [button.superview endEditing:YES];
    [button.superview.popupController dismissViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
