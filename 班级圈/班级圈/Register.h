//
//  Register.h
//  班级圈
//
//  Created by Jep Xia on 2017/3/30.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register : UIViewController
@property (nonatomic,retain)UILabel* lbUserName; //显示名字
@property (nonatomic,retain)UILabel* lbTextCode; //显示名字
@property (nonatomic,retain)UILabel* lbSetPassword; //显示名字
@property (nonatomic,retain)UILabel* lbConfirmPassword; //显示名字
@property (nonatomic,retain)UIButton* btGetCode;
@property (nonatomic,retain)UIButton* btRegister;
@property (nonatomic,retain)UITextField* txCode;
@property (nonatomic,retain)UITextField* txUsername;
@property (nonatomic,retain)UITextField* txSetPassword;
@property (nonatomic,retain)UITextField* txConfirmPassword;


@end
