//
//  SettingsViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/5/3.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "SettingsViewController.h"
#import <Masonry.h>
@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(void)logout{
    
    UIAlertController *alerController  = [UIAlertController alertControllerWithTitle:@"你确定要注销吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"uid"];
        [defaults removeObjectForKey:@"token"];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alerController addAction:OKAction];
    [alerController addAction:cancelAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* logoutBtn = [UIButton new];
    [logoutBtn setTitle:@"注销" forState:UIControlStateNormal];
    [logoutBtn setBackgroundColor:[UIColor redColor]];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.layer.cornerRadius = 5;
    [self.view addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view).offset(100);
    }];
    
    
    
    
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
