//
//  Login.h
//  班级圈
//
//  Created by Jep Xia on 2017/3/27.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController
@property (nonatomic,retain)UILabel* lbUsername; //显示名字
@property (nonatomic,retain)UILabel* lbPassword; //显示名字
@property (nonatomic,retain)UIImageView* backgroundImage; //显示名字
@property (nonatomic,retain)UIImageView* userPortraitImage; //显示名字
@property (nonatomic,retain)UITextField* txUsername;
@property (nonatomic,retain)UITextField* txPassword;
@property (nonatomic,retain)UIButton* btLogin;
@property (nonatomic,retain)UIButton* btRegister;
@property (nonatomic,retain)UIButton* userPotrait;


@end
