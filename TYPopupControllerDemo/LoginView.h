//
//  LoginView.h
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

+ (instancetype)createViewFromNib;

@end
