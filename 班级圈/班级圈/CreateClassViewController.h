//
//  CreateClassViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/17.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateClassSubView.h"

@interface CreateClassViewController : UIViewController
@property (nonatomic,retain)UILabel* lbCity; //显示名字
@property (nonatomic,retain)UILabel* lbKind; //显示名字
@property (nonatomic,retain)UILabel* lbArea; //显示名字
@property (nonatomic,retain)UILabel* lbOrganizationName; //显示名字
@property (nonatomic,retain)UITextField* txClassName;
@property (nonatomic,retain)UIButton* leftBtn;
@property (nonatomic,retain)UIButton* rightBtn;
@property (nonatomic,retain)CreateClassSubView* cityView;
@property (nonatomic,retain)CreateClassSubView* kindView;
@property (nonatomic,retain)CreateClassSubView* areaView;
@property (nonatomic,retain)CreateClassSubView* organizeView;

@end
