//
//  ScheduleViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/28.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "ScheduleViewController.h"
#import <Masonry.h>
@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView* image = [UIImageView new];
    image.image = [UIImage imageNamed:@"日程.jpg"];
    [self.view addSubview:image];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerX.centerY.equalTo(self.view);
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
