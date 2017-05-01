//
//  JoinClassViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/20.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "JoinClassViewController.h"
#import <Masonry.h>
#import "JoinExactClassViewController.h"
#import <AFNetworking.h>
#import "GlobalVar.h"
@interface JoinClassViewController ()
@property (nonatomic, retain)UITextField* txClassNum;
@property (nonatomic, retain)UIButton* secondView;
@property (nonatomic, retain)UIButton* joinClassBtn;
@property (nonatomic, retain)NSString* sessionUrl;
@property (nonatomic, retain)NSDictionary* parameters;
@end

@implementation JoinClassViewController

-(void)didTouchBtn:(UIButton *)sender
{
    if (sender.tag == self.secondView.tag) {
        JoinExactClassViewController* joinExactClassVC = [[JoinExactClassViewController alloc] init];
        [self.navigationController pushViewController:joinExactClassVC animated:true];
    } else if (sender.tag == self.joinClassBtn.tag) {
        [self joinClass];
    }
}

-(void)joinClass
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/class/searchByCode" ];
    //创建多个字典
    
    self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                       userid,@"userId",
                       self.txClassNum.text,@"code",
                       nil];
    
    NSLog(@"parameters :%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    
    [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [session POST:self.sessionUrl parameters:self.parameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@", responseObject);
              if ([[responseObject objectForKey:@"status"] isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                  UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"加入成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:OKAction];
                  
                  [self presentViewController:alertController animated:YES completion:nil];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          }];
    
}

-(void)popAlertAction:(NSString *)title
{
    
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

-(void)createUI
{
    
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    
    UIView* firstView = [UIView new];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.width.equalTo(self.view.mas_width);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(44);
    }];
    
    UILabel* lbClassNum = [UILabel new];
    lbClassNum.text = @"邀请码";
    [firstView addSubview:lbClassNum];
    [lbClassNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstView.mas_left).offset(15);
        make.centerY.equalTo(firstView.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(60);
        
    }];
    
    self.txClassNum = [UITextField new];
    self.txClassNum.placeholder = @"请输入班级邀请码";
    [firstView addSubview:self.txClassNum];
    [self.txClassNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbClassNum.mas_right).offset(20);
        make.centerY.equalTo(firstView.mas_centerY);
        make.height.mas_equalTo(15);
        make.right.equalTo(firstView.mas_right).offset(-10);
    }];
    
    self.secondView = [UIButton new];
    self.secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.secondView];
    [self.secondView setTag:0];
    [self.secondView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(15);
        make.width.equalTo(self.view.mas_width);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView* searchImg = [UIImageView new];
    [self.secondView addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondView.mas_left).offset(15);
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self.secondView.mas_centerY);
    }];
    
    UIImageView* rightArrowImg = [UIImageView new];
    [rightArrowImg setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [self.secondView addSubview:rightArrowImg];
    [rightArrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondView.mas_right).offset(-10);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(11);
        make.centerY.equalTo(self.secondView.mas_centerY);
    }];
    
    
    UILabel* lbSearchClass = [UILabel new];
    lbSearchClass.text = @"精确查找班级";
    [self.secondView addSubview:lbSearchClass];
    [lbSearchClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right).offset(20);
        make.right.equalTo(rightArrowImg.mas_left).offset(-10);
        make.height.mas_equalTo(22);
        make.centerY.equalTo(self.secondView.mas_centerY);
    }];
    
    self.joinClassBtn = [UIButton new];
    [self.joinClassBtn setTag:1];
    [self.joinClassBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.joinClassBtn setTitle:@"申请加入" forState:UIControlStateNormal];
    [self.joinClassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.joinClassBtn.layer.cornerRadius = 5;
    [self.joinClassBtn setBackgroundColor:[GlobalVar themeColorGetter]];
    [self.view addSubview:self.joinClassBtn];
    [self.joinClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondView.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查找班级";
    [self initNavigation];
    [self createUI];
    
    
    // Do any additional setup after loading the view.
}

-(void)initNavigation
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
