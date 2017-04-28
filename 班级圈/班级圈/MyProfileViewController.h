//
//  MyProfileViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/16.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MyProfileModel.h"
@interface MyProfileViewController : UIViewController


@property (nonatomic,retain)UILabel* lbUsername; //显示名字
@property (nonatomic,retain)UILabel* lbPhoneNumber; //显示名字
@property (nonatomic,retain)UILabel* lbUserDescription; //显示名字
@property (nonatomic,retain)UIImageView* backgroundImage; //显示名字
@property (nonatomic,retain)UIImageView* userPortraitImage; //显示名字
@property (strong,nonatomic) User* user;
@property (strong,nonatomic) MyProfileModel* myProfileModel;
@property (nonatomic,retain)UILabel* lbRegion; //显示名字




//@property (nonatomic,retain)UIImageView* userPortraitImage; //显示名字
//@property (nonatomic,retain)UITextField* txUsername;
//@property (nonatomic,retain)UITextField* txPassword;
//@property (nonatomic,retain)UIButton* btLogin;
//@property (nonatomic,retain)UIButton* btRegister;
//@property (nonatomic,retain)UIButton* userPotrait;
@end
