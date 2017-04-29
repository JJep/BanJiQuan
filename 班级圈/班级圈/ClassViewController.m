//
//  ClassViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/27.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "ClassViewController.h"
#import <Masonry.h>
#import "GlobalVar.h"
@interface ClassViewController ()
@property (nonatomic,retain)UIImageView* backgroundImage;
@property (nonatomic,retain)UIImageView* classPortrait;
@property (nonatomic,retain)UILabel* className;
@property (nonatomic,retain)UILabel* classDescription;
@property (nonatomic,retain)UILabel* classCardName;
@property (nonatomic,retain)UILabel* codeSubview;
@end

@implementation ClassViewController

-(void)initNavigation
{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

-(void)createUI
{
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    
    //
    self.backgroundImage = [UIImageView new];
    self.classPortrait = [UIImageView new];
    self.className = [UILabel new];
    self.classDescription = [UILabel new];
    
    //设置控件颜色
    self.backgroundImage.backgroundColor = [GlobalVar themeColorGetter];
    self.className.textColor = [UIColor whiteColor];
    self.classDescription.textColor = [UIColor whiteColor];
    
    self.className.text = @"班级名称";
    self.classDescription.text = @"班级介绍";
    self.classDescription.font = [UIFont systemFontOfSize:15];
    self.classPortrait.image = [UIImage imageNamed:@"userPortrait.jpg"];
    
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage addSubview:self.classPortrait];
    [self.backgroundImage addSubview:self.className];
    [self.backgroundImage addSubview:self.classDescription];
    
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.height.mas_equalTo(152);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    [self.classPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundImage.mas_left).offset(10);
        make.bottom.equalTo(self.backgroundImage.mas_bottom).offset(-10);
        make.height.width.mas_equalTo(50);
    }];
    
    [self.className mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classPortrait.mas_right).offset(10);
        make.top.equalTo(self.classPortrait.mas_top).offset(3);
        make.right.equalTo(self.backgroundImage.mas_right).offset(-10);
    }];
    
    [self.classDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.className);
        make.bottom.equalTo(self.classPortrait.mas_bottom).offset(-3);
        make.right.equalTo(self.backgroundImage.mas_right).offset(10);
    }];
    
    
    //
    UIView* assistView1 = [UIView new];
    assistView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:assistView1];
    
    UIButton* classAnnouncement = [UIButton new];
    [assistView1 addSubview:classAnnouncement];
    UIButton* classFiles = [UIButton new];
    [assistView1 addSubview:classFiles];
    UIButton* classTimeLabel = [UIButton new];
    [assistView1 addSubview:classTimeLabel];
    UIImage* classAnnoucementImage = [UIImage imageNamed:@"class_班级公告"];
    UIImage* classFilesImage = [UIImage imageNamed:@"class_班级文件"];
    UIImage* classTimeLabelImage = [UIImage imageNamed:@"class_班级课表"];
    [classAnnouncement setImage:classAnnoucementImage forState:UIControlStateNormal];
    [classFiles setImage:classFilesImage forState:UIControlStateNormal];
    [classTimeLabel setImage:classTimeLabelImage forState:UIControlStateNormal];
    
    [assistView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImage.mas_bottom);
        make.height.mas_equalTo(72);
        make.centerX.width.equalTo(self.view);
    }];
    
    
    [classAnnouncement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);

        make.left.equalTo(assistView1.mas_left).offset(10);
        make.centerY.equalTo(assistView1);
    }];
    
    [classFiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);
        make.left.equalTo(classAnnouncement.mas_right).offset(19);
        make.centerY.equalTo(assistView1);
    }];
    
    [classTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);

        make.left.equalTo(classFiles.mas_right).offset(19);
        make.centerY.equalTo(assistView1);
    }];
    
    //
    UIButton* classCardBtn = [UIButton new];
    [self.view addSubview:classCardBtn];
    [classCardBtn setBackgroundColor:[UIColor whiteColor]];
    [classCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(assistView1.mas_bottom).offset(10);
        make.width.centerX.left.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    UILabel* classCardLabel = [UILabel new];
    [classCardBtn addSubview:classCardLabel];
    classCardLabel.text = @"我的班级名片";
    [classCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classCardBtn.mas_left).offset(20);
        make.centerY.equalTo(classCardBtn);
    }];
    
    UIImageView* arrowImage = [UIImageView new];
    [arrowImage setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [classCardBtn addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(classCardBtn.mas_right).offset(-15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(classCardBtn);
    }];
    
    self.classCardName = [UILabel new];
    [classCardBtn addSubview:self.classCardName];
    self.classCardName.textColor = [UIColor grayColor];
    self.classCardName.text = @"未设置";
    self.classCardName.textAlignment = NSTextAlignmentRight;
    [self.classCardName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImage.mas_left).offset(-10);
        make.centerY.equalTo(classCardBtn);
    }];
    
    UIButton* assistViewLeft = [UIButton new];
    UIButton* assistViewRight = [UIButton new];
    [assistViewLeft setBackgroundColor:[UIColor whiteColor]];
    [assistViewRight setBackgroundColor:[UIColor whiteColor]];
    [assistViewLeft setTitle:@"家长群" forState:UIControlStateNormal];
    [assistViewRight setTitle:@"学生群" forState:UIControlStateNormal];
    [assistViewLeft setTitleColor:[GlobalVar themeColorGetter] forState:UIControlStateSelected];
    [assistViewLeft setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [assistViewRight setTitleColor:[GlobalVar themeColorGetter] forState:UIControlStateSelected];
    [assistViewRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:assistViewRight];
    [self.view addSubview:assistViewLeft];
    
    [assistViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classCardBtn.mas_bottom).offset(10);
        make.left.equalTo(self.view);
        make.width.equalTo(assistViewRight);
        make.right.equalTo(assistViewRight.mas_left);
        make.height.mas_equalTo(44);
    }];
    
    [assistViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classCardBtn.mas_bottom).offset(10);
        make.right.equalTo(self.view);
        make.left.equalTo(assistViewLeft.mas_right);
        make.width.equalTo(assistViewLeft);
        make.height.mas_equalTo(44);
    }];
    
    
    //classMember
    UIButton* classMembersBtn = [UIButton new];
    [classMembersBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:classMembersBtn];
    UIImageView* classMemberImage = [UIImageView new];
    classMemberImage.image = [UIImage imageNamed:@""];
    
    [classMembersBtn addSubview:classMemberImage];

    [classMembersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(assistViewLeft.mas_bottom).offset(1);
        make.height.mas_equalTo(74);
        make.centerX.width.equalTo(self.view);
    }];
    
    [classMemberImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classMembersBtn).offset(15);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(30);
        make.centerY.equalTo(classMembersBtn);
    }];
    
    UIImageView* arrow2 = [UIImageView new];
    [arrow2 setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [classMembersBtn addSubview:arrow2];
    [arrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(classMembersBtn.mas_right).offset(-15);
        make.centerY.equalTo(classMembersBtn);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel* memberNum = [UILabel new];
    memberNum.text = @"100名成员";
    memberNum.textColor = [UIColor grayColor];
    memberNum.textAlignment = NSTextAlignmentRight;
    [classMembersBtn addSubview:memberNum];
    [memberNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrow2.mas_left);
        make.centerY.equalTo(classMembersBtn);
    }];
    
    UIButton* codeBtn = [UIButton new];
    [self.view addSubview:codeBtn];
    [codeBtn setBackgroundColor:[UIColor whiteColor]];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classMembersBtn.mas_bottom).offset(1);
        make.height.mas_equalTo(44);
        make.width.centerX.equalTo(self.view);
    }];
    
    UILabel* codeLabel = [UILabel new];
    [codeBtn addSubview:codeLabel];
    codeLabel.text = @"家长邀请码";
    self.codeSubview = [UILabel new];
    [codeBtn addSubview:self.codeSubview];
    self.codeSubview.text = @"未设置";
    self.codeSubview.textColor = [UIColor grayColor];
    self.codeSubview.textAlignment = NSTextAlignmentRight;
    UIImageView* arrow3 = [UIImageView new];
    [arrow3 setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [codeBtn addSubview:arrow3];
    [arrow3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeBtn).offset(-15);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(codeBtn);
    }];
    
    
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classMembersBtn).offset(1);
        make.left.equalTo(codeBtn).offset(10);
        make.centerY.equalTo(codeBtn);
    }];

    [self.codeSubview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrow3.mas_right).offset(-10);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(codeBtn);
    }];
    
    UIButton* enterChat = [UIButton new];
    [enterChat setBackgroundColor:[GlobalVar themeColorGetter]];
    [self.view addSubview:enterChat];
    [enterChat setTitle:@"进入家长聊" forState:UIControlStateNormal];
    [enterChat addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpOutside];
    [enterChat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeBtn.mas_bottom).offset(32);
        make.width.mas_equalTo(345);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self.view);
    }];
    enterChat.layer.cornerRadius = 5;
}

-(void)didTouchBtn:(UIButton *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    [self initNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
