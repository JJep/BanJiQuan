//
//  EditProfileViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/25.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "EditProfileViewController.h"
#import "EditProfileTableViewCell.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "GlobalVar.h"

@interface EditProfileViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
}
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@end

@implementation EditProfileViewController

-(void)uploadProfile
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
//    if (userid) {
//        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/user/updateif" ];
//        //创建多个字典
//        self.parameters = [NSDictionary dictionaryWithObject:userid forKey:@"userId"];
//        
//        NSLog(@"parameters :%@", self.parameters);
//        
//        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
//        session.responseSerializer = [AFJSONResponseSerializer serializer];
//        
//        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//        [session GET:self.sessionUrl
//          parameters:self.parameters
//            progress:nil
//             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                 NSLog(@"%@",responseObject);
//                 //根据key获取value
//                 NSNumber* status = [responseObject objectForKey:@"status"];
//                 if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
//                     
//                     self.classes = [responseObject objectForKey:@"classes"];
//                     NSLog(@"%@", self.classes);
//                     
//                     
//                     self.MomentArray = [responseObject objectForKey:@"titles"];
//                     
//                     
//                     [_tableView reloadData];
//                     
//                 }
//                 
//             }
//             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                 NSLog(@"failure");
//                 NSLog(@"%@", error);
//             }
//         ];
//    }
}


- (void)viewDidLoad {
    self.hidesBottomBarWhenPushed = true;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView.hidden = false;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [GlobalVar grayColorGetter];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[EditProfileTableViewCell class] forCellReuseIdentifier:@"CELL"];

    [self initNavigation];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 3;
    } else {
        return 0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    NSString* key = [[NSString alloc] init];
    NSString* value = [[NSString alloc] init];
    key = @"";
    value = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            key = @"头像";
            UIImage* img = [UIImage imageNamed:@"头像大"];
            img = [img imageWithRenderingMode:UIImageRenderingModeAutomatic];
            [cell.cellImage setImage:[UIImage imageNamed:@"头像大"]];
            
        } else if (indexPath.row == 1)
        {
            key = @"昵称";
        } else if (indexPath.row == 2) {
            key = @"手机号";
        } else if (indexPath.row == 3) {
            key = @"我的二维码";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            key = @"性别";
        } else if (indexPath.row == 1) {
            key = @"地区";
        } else if (indexPath.row == 2) {
            key = @"个人描述";
        }
    }

    cell.cellKey.text = key;
    cell.cellValue.text = value;
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"CELL";
    EditProfileTableViewCell *cell =(EditProfileTableViewCell *)([_tableView dequeueReusableCellWithIdentifier:identifier]);

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return cell.frame.size.height+60;
        }
    }
    return cell.frame.size.height;
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
