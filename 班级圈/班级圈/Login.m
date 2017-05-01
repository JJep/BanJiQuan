//
//  Login.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/27.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "Login.h"
#import "Register.h"
#import <AFNetworking.h>
#import "GlobalVar.h"

@interface Login () <UITextFieldDelegate>
@property (strong,nonatomic) NSString* sessionUrl;
@property (strong,nonatomic) NSDictionary* parameters;
@end

@implementation Login

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txPassword resignFirstResponder];
    [self.txUsername resignFirstResponder];
    return NO;
}

-(void) pushToRegister
{
    Register* registerVC = [[Register alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void) toLogin
{
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/user/LoginByPassWord" ];
    //创建多个字典
    self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                       self.txUsername.text, @"phoneNumber",
                       self.txPassword.text, @"passWord",
                       nil];
    NSLog(@"parameters :%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    [session POST:self.sessionUrl parameters:self.parameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@",responseObject);
              //根据key获取value
              NSNumber* status = [responseObject objectForKey:@"status"];
              NSLog(@"%@",status);
              int myInt = [status intValue];
              if (myInt == 0) {
                  NSLog(@"success");
                  //UIAlertController风格：UIAlertControllerStyleAlert
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录成功"
                                                                                           message:@"..."
                                                                                    preferredStyle:UIAlertControllerStyleAlert ];
                  
                  //添加取消到UIAlertController中
                  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:cancelAction];
                  
                  //添加确定到UIAlertController中
                  UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:OKAction];
                  
                  
                  //将用户登录信息保存到本地
                  NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                  NSString *token =[responseObject objectForKey:@"token"];
                  NSNumber *userid = [responseObject objectForKey:@"uid"];
                  [defaults setObject:token forKey:@"token"];
                  [defaults setObject:userid forKey:@"uid"];
                  NSLog(@"保存成功");
                  NSString *usertoken = [defaults objectForKey:@"token"];//根据键值取出name
                  NSNumber *useruserid = [defaults objectForKey:@"uid"];
                  NSLog(@"usertoken = %@,userid = %@",usertoken,useruserid);
                  
                  
                  [self presentViewController:alertController animated:YES completion:nil];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"failure");
              NSLog(@"%@", error);
          }
     ];
}


-(void)AFNetMonitor
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络连接");
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"4g");
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
                
            default:
                break;
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self initNavigation];
    
    self.txUsername.delegate = self;
    self.txPassword.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)initNavigation{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (void) createUI {
    UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    UIView* lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2-22 , self.view.bounds.size.width-20, 1)];
    UIView* lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.view.bounds.size.height/2+14 , self.view.bounds.size.width-20, 1)];
    self.userPotrait = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 -60, 94, 120, 120)];
    self.lbUsername = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2-50, 40, 18)];
    self.lbPassword = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.height/2 -12, 40, 18)];
    self.txUsername = [[UITextField alloc] initWithFrame:CGRectMake(80, self.view.bounds.size.height/2 -50, 260, 18)];
    self.txPassword = [[UITextField alloc] initWithFrame:CGRectMake(80, self.view.bounds.size.height/2 - 12, 260, 18)];

    self.btLogin = [[UIButton alloc] initWithFrame:CGRectMake(15,
                                                                   self.view.bounds.size.height/2 + 40,
                                                                   self.view.bounds.size.width - 30,
                                                                   44)];
    self.btRegister = [[UIButton alloc] initWithFrame:CGRectMake(15,
                                                                      self.view.bounds.size.height/2 + 104,
                                                                      self.view.bounds.size.width - 30,
                                                                      44)];
    
    self.userPotrait.backgroundColor = [UIColor colorWithRed:41.0/255 green:169.0/255 blue:255.0/255 alpha:1];
    self.userPotrait.layer.cornerRadius = 60;
    self.userPotrait.layer.masksToBounds = YES;
    self.lbUsername.text = @"用户:";
    self.lbPassword.text = @"密码:";
    self.txUsername.placeholder = @"请输入手机号";
    self.txPassword.placeholder = @"请输入密码";
    self.btLogin.backgroundColor = [UIColor colorWithRed:41.0/255 green:169.0/255 blue:255.0/255 alpha:1];
    [self.btLogin setTitle:@"登     陆" forState:UIControlStateNormal];
    self.btRegister.backgroundColor = [UIColor greenColor];
    [self.btRegister setTitle:@"注     册" forState:UIControlStateNormal];
    self.btRegister.layer.cornerRadius = 5;
    self.btLogin.layer.cornerRadius = 5;
    [self.btRegister addTarget:self action:@selector(pushToRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.btLogin addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundImage setImage:[UIImage imageNamed:@"背景"]];
    
    lineView1.backgroundColor = [UIColor grayColor];
    lineView2.backgroundColor = [UIColor grayColor];
    
    
    [self.view addSubview:backgroundImage];
    [self.view addSubview:lineView1];
    [self.view addSubview:lineView2];
    [self.view addSubview:self.btLogin];
    [self.view addSubview:self.userPotrait];
    [self.view addSubview:self.lbUsername];
    [self.view addSubview:self.lbPassword];
    [self.view addSubview:self.txUsername];
    [self.view addSubview:self.txPassword];
    [self.view addSubview:self.btRegister];
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
