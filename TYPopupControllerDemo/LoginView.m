//
//  LoginView.m
//  TYPopupControllerDemo
//
//  Created by tany on 16/10/21.
//  Copyright © 2016年 tany. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

+ (instancetype)createViewFromNib
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    return [nib objectAtIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
