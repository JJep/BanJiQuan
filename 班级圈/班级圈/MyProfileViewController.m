//
//  MyProfileViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/16.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "MyProfileViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "GlobalVar.h"
#import "MyProfileModel.h"
#import "User.h"
#import "EditProfileViewController.h"

@interface MyProfileViewController ()
@property (strong,nonatomic) NSString* sessionUrl;
@property (strong,nonatomic) NSDictionary* parameters;

@property (strong,nonatomic) UIView* portraitView;
@end
@implementation MyProfileViewController

-(void)loadUI
{
    
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    self.backgroundImage = [[UIImageView alloc] init];
    self.backgroundImage.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:235.0/255.0 blue:1 alpha:1];
    self.backgroundImage.image = [UIImage imageNamed:@"flower.jpg"];
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(186);
    }];
    
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    self.userPortraitImage = [UIImageView new];
    [self.userPortraitImage setImage:[UIImage imageNamed:@"userPortrait.jpg"]];
    self.portraitView = [UIView new];
    
    [self.portraitView addSubview:self.userPortraitImage];

    [self.view addSubview:self.portraitView];

    
    [self.portraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backgroundImage.mas_bottom);
        make.width.height.mas_equalTo(95);
        make.centerX.equalTo(self.view);

    }];
    
    [self.userPortraitImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.portraitView).offset(-1);
        make.center.equalTo(self.portraitView);
    }];
    
    
    self.lbUsername = [UILabel new];
    self.lbUsername.text = @"昵称";
    [self.view addSubview:self.lbUsername];
    [self.lbUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.portraitView.mas_bottom).offset(10);
//        make.left.equalTo(self.userPortraitImage.mas_left);
        make.centerX.equalTo(self.view);
    }];
    
    self.lbPhoneNumber = [UILabel new];
    self.lbPhoneNumber.text = @"账号:";
    [self.view addSubview:self.lbPhoneNumber];
    [self.lbPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbUsername.mas_bottom).offset(10);
//        make.left.equalTo(self.userPortraitImage.mas_left);
        make.centerX.equalTo(self.view);
    }];
    
    self.lbUserDescription = [UILabel new];
    self.lbUserDescription.text = @"这个家伙很懒，什么都没写";
    [self.view addSubview:self.lbUserDescription];
    [self.lbUserDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhoneNumber.mas_bottom).offset(10);
//        make.left.equalTo(self.userPortraitImage.mas_left);
        make.centerX.equalTo(self.view);
    }];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backgroundImage.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.lbUserDescription.mas_bottom).offset(10);
    }];

    
    UIView* backView2 = [UIView new];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundView.mas_bottom).offset(10);
        make.width.equalTo(self.view.mas_width);
    }];
    
    UILabel* regionLabel = [UILabel new];
    regionLabel.text = @"地区";
    regionLabel.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1];
    [self.view addSubview:regionLabel];
    [regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_top).offset(10);
        make.left.mas_equalTo(20);
    }];
    
    [backView2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(regionLabel.mas_bottom).offset(10);
    }];
    
    UIView* view3 = [UIView new];
    view3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView2.mas_bottom).offset(1);
        make.width.equalTo(self.view.mas_width);
    }];
    
    UILabel* moments = [UILabel new];
    moments.text = @"最近动态";
    moments.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1];
    [self.view addSubview:moments];
    [moments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view3.mas_centerY);
        make.left.mas_equalTo(20);
    }];
    
    UIImageView* arrow1 = [UIImageView new];
    [arrow1 setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [self.view addSubview:arrow1];
    [arrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(22);
        make.right.equalTo(view3.mas_right).offset(-10);
        make.centerY.equalTo(view3.mas_centerY);
    }];
    
    
    self.lbRegion = [UILabel new];
    if (!self.user.area) {
        self.lbRegion.text = (NSString*)self.user.area;
    }
    
    [self.view addSubview:self.lbRegion];
    [self.lbRegion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regionLabel);
        make.bottom.equalTo(regionLabel);
        
    }];
    
    
    
    UIImageView* image1 = [UIImageView new];
    image1.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:235.0/255.0 blue:1 alpha:1];
    [image1 setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:image1];
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_top).offset(5);
        make.bottom.equalTo(view3.mas_bottom).offset(-5);
        make.left.equalTo(moments.mas_right).offset(10);
        make.width.height.mas_equalTo(55);
    }];
    
    [self.lbRegion mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image1.mas_left);
    }];
    
    UIImageView* image2 = [UIImageView new];
    image2.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:235.0/255.0 blue:1 alpha:1];
    [image2 setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:image2];
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image1.mas_top);
        make.width.height.mas_equalTo(55);
        make.left.equalTo(image1.mas_right).offset(10);
    }];

    
    UIImageView* image3 = [UIImageView new];
    image3.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:235.0/255.0 blue:1 alpha:1];
    [image3 setImage:[UIImage imageNamed:@""]];
    [self.view addSubview:image3];
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image1.mas_top);
        make.width.height.mas_equalTo(55);
        make.left.equalTo(image2.mas_right).offset(10);
    }];
     
    UIView* view4 = [UIView new];
    view4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(1);
        make.width.equalTo(self.view.mas_width);
    }];
    
    UILabel* lbMore = [UILabel new];
    lbMore.text = @"更多";
    lbMore.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1];
    [self.view addSubview:lbMore];
    [lbMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.equalTo(view4.mas_top).offset(10);
        make.bottom.equalTo(view4.mas_bottom).offset(-10);
    }];
    
    UIImageView* arrow2 = [UIImageView new];
    [arrow2 setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [self.view addSubview:arrow2];
    [arrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(22);
        make.right.equalTo(view4.mas_right).offset(-10);
        make.centerY.equalTo(view4.mas_centerY);
    }];

    
}

-(void )viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.portraitView.backgroundColor = [UIColor whiteColor];
    self.portraitView.layer.cornerRadius = self.portraitView.bounds.size.width/2.0;//设置那个圆角的有搜索多圆
    self.portraitView.layer.masksToBounds = YES;
//    self.userPortraitImage.layer.cornerRadius = self.userPortraitImage.bounds.size.width/2;
}


-(void)updateUI
{
    NSLog(@"%@", self.myProfileModel);
    if(self.myProfileModel.user.username ) {
        self.lbUsername.text = (NSString*)self.myProfileModel.user.username;
    }
    if(self.myProfileModel.user.phonenumber ) {
        self.lbPhoneNumber.text = [NSString stringWithFormat:@"%@%@", @"账号:",self.myProfileModel.user.phonenumber];
    }
    if(self.myProfileModel.user.area ) {
        self.lbRegion.text = (NSString*)self.myProfileModel.user.area;
    }
    if(self.myProfileModel.user.descriptionField ) {
        self.lbUserDescription.text = (NSString*)self.myProfileModel.user.descriptionField;
    }
    
    NSLog(@"updateUI");
    NSLog(@"%@", self.myProfileModel.user.phonenumber);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    [self.tabBarController.tabBar setHidden:true];
   
    self.navigationItem.title = @"MyProfile";
    NSLog(@"%@", self.user);
    [self initNavigation];
    [self loadUI];
    [self updateUI];

}

-(void)didTouchNavigationItem:(UINavigationItem*) sender
{
    EditProfileViewController* editProfileVC = [[EditProfileViewController alloc] init];
    [self.navigationController pushViewController:editProfileVC animated:true];
}


-(void)initNavigation
{

    UIImage* COGImg = [UIImage imageNamed:@"COG"];
    COGImg = [COGImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:COGImg style:UIBarButtonItemStyleDone target:self action:@selector(didTouchNavigationItem:)];
    [self.navigationItem.rightBarButtonItem setTag:-10];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }


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
