//
//  Register.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/30.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "Register.h"
#import <AFNetworking.h>
#import "GlobalVar.h"

@interface Register ()
@property (strong, nonatomic) NSString* sessionUrl;
@property (strong, nonatomic) NSDictionary* parameters;

@end

@implementation Register

-(void)getCode
{
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/user/getRegisterCode" ];
    self.parameters = [NSDictionary dictionaryWithObject:
                       self.txUsername.text forKey:@"phoneNumber"];
    NSLog(@"parameters :%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    [session POST:self.sessionUrl parameters:self.parameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"succes");
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"failure");
          }
     ];

}

-(void) btToRegister
{
    if ([self.txSetPassword.text isEqualToString:self.txConfirmPassword.text]) {
        [self toRegister];
    } else {
        NSLog(@"两次密码输入错误");
    }

}

-(void)toRegister
{
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/user/userRegister" ];
    //创建多个字典
    self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                       self.txUsername.text, @"phoneNumber",
                       self.txCode.text, @"code",
                       self.txConfirmPassword.text, @"passWord",
                       nil];
    NSLog(@"parameters :%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    [session POST:self.sessionUrl parameters:self.parameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"succes");
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"failure");
          }
     ];
    
}
         
         

- (void) createUI {
    UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    

    UIButton* userPotrait = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 -60, 94, 120, 120)];
    
    
    //设置标签
    self.lbUserName = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2-50 -10, 80, 18)];
    self.lbTextCode = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2 -12 -10, 80, 18)];
    self.lbSetPassword = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2 - 12-10 + 38 , 80, 18)];
    self.lbConfirmPassword = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2 - 10 -12 + 38 + 38, 80, 18)];
    
    
    //设置textfield
    self.txUsername = [[UITextField alloc] initWithFrame:CGRectMake(120, self.view.bounds.size.height/2 -50 -10, 260, 18)];
    self.txCode = [[UITextField alloc] initWithFrame:CGRectMake(120, self.view.bounds.size.height/2 - 12-10, 260, 18)];
    self.txSetPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, self.view.bounds.size.height/2 - 12-10 + 38, 260, 18)];
    self.txConfirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(120, self.view.bounds.size.height/2 - 12-10 + 38*2, 260, 18)];
    
    
    //设置辅助线
    UIView* lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2-50 +22-10 , self.view.bounds.size.width-20, 1)];
    UIView* lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2-12+22 -10, self.view.bounds.size.width-20, 1)];
    UIView* lineView3 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2 -12 +38-10 +22 , self.view.bounds.size.width-20, 1)];
    UIView* lineView4 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2 - 12 +38+38+22-10, self.view.bounds.size.width-20, 1)];
    
    
    
    //设置button
    self.btRegister = [[UIButton alloc] initWithFrame:CGRectMake(15,
                                                                   self.view.bounds.size.height/2 + 40 + 38*2,
                                                                   self.view.bounds.size.width - 30,
                                                                   44)];
    self.btGetCode = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 8 - 90, self.view.bounds.size.height/2 -50-15, 90, 22)];
    
    
    
    
    userPotrait.backgroundColor = [UIColor colorWithRed:41.0/255 green:169.0/255 blue:255.0/255 alpha:1];
    userPotrait.layer.cornerRadius = 60;
    userPotrait.layer.masksToBounds = YES;
    
    
    self.lbUserName.text = @"用户账号:";
    self.lbTextCode.text = @"验  证  码:";
    self.lbSetPassword.text = @"设置密码:";
    self.lbConfirmPassword.text = @"确认密码:";
    
    
    
    self.txUsername.placeholder = @"请输入手机号";
    self.txCode.placeholder = @"请输入验证码";
    self.txSetPassword.placeholder = @"请设置密码";
    self.txConfirmPassword.placeholder = @"请确认密码";
    
    
    self.btRegister.backgroundColor = [UIColor colorWithRed:41.0/255 green:169.0/255 blue:255.0/255 alpha:1];
    [self.btRegister setTitle:@"注     册" forState:UIControlStateNormal];
    self.btRegister.layer.cornerRadius = 5;
    [self.btGetCode setTitle:@"获取验证码" forState: UIControlStateNormal];
    self.btGetCode.backgroundColor = [UIColor colorWithRed:41.0/255 green:169.0/255 blue:255.0/255 alpha:1];
    self.btGetCode.layer.cornerRadius = 5;
    self.btGetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btGetCode addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.btRegister addTarget:self action:@selector(btToRegister) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImage setImage:[UIImage imageNamed:@"背景"]];
    
    
    
    lineView1.backgroundColor = [UIColor grayColor];
    lineView2.backgroundColor = [UIColor grayColor];
    lineView3.backgroundColor = [UIColor grayColor];
    lineView4.backgroundColor = [UIColor grayColor];
    
    
    
    
    
    [self.view addSubview:backgroundImage];
    [self.view addSubview:lineView1];
    [self.view addSubview:lineView4];
    [self.view addSubview:lineView3];
    [self.view addSubview:self.lbSetPassword];
    [self.view addSubview:self.lbConfirmPassword];
    [self.view addSubview:lineView2];
    [self.view addSubview:self.btRegister];
    [self.view addSubview:userPotrait];
    [self.view addSubview:self.lbUserName];
    [self.view addSubview:self.lbTextCode];
    
    [self.view addSubview:self.txUsername];
    [self.view addSubview:self.txCode];
    [self.view addSubview:self.txSetPassword];
    [self.view addSubview:self.txConfirmPassword];
    
    
    [self.view addSubview:self.btGetCode];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self initNavigation];
    // Do any additional setup after loading the view.
}

-(void) initNavigation
{
    
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
