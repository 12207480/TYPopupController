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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)popupControllerAction:(id)sender {
    TYPopupController *popupController = [TYPopupController popupControllerWithController:[PopViewController new] size:CGSizeMake(200, 300) animatorClass:[TYScaleFadeAnimator class]];
    [self presentViewController:popupController animated:YES completion:nil];
}

- (IBAction)popupViewAction:(id)sender {
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    popView.backgroundColor = [UIColor redColor];
    TYPopupController *popupController = [TYPopupController popupControllerWithView:popView];
    [self presentViewController:popupController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
