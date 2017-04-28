//
//  MeViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/28.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeadTableViewCell.h"
#import <Masonry.h>
#import "MyProfileViewController.h"
#import "CreateClassViewController.h"
#import "JoinClassViewController.h"
#import "NewMomentViewController.h"
#import "UIImagePickerViewController.h"
#import "TeacherConfirmViewController.h"
#import "GlobalVar.h"
#import "DefaultTableViewCell.h"
#import "MyProfileModel.h"
#import <AFNetworking.h>
#import "ClassViewController.h"

@interface MeViewController ()
@property(nonatomic,retain)NSString* sessionUrl;
@property (strong,nonatomic) MyProfileModel* myProfileModel;
@property (nonatomic,retain)NSDictionary* parameters;
@end

static NSString *const cellIdentifier =@"cellIdentifier";
static NSString *const context = @"这个人懒得要死，啥都没写";
@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
    [self loadTableView];
    [self downloadData];
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

- (void)loadTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView.hidden = false;
    _tableView.tableFooterView = [[UITableViewHeaderFooterView alloc] init];
    _tableView.backgroundColor = [GlobalVar grayColorGetter];
    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[MeHeadTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerClass:[DefaultTableViewCell class] forCellReuseIdentifier:@"DEFAULTCELL"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    MeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (self.myProfileModel) {
            cell.userName.text = (NSString*)self.myProfileModel.user.username;
            cell.userPhoneNumber.text = [NSString stringWithFormat:@"%@%@", @"账号:",self.myProfileModel.user.phonenumber];
            cell.userDescription.text = (NSString*)self.myProfileModel.user.descriptionField;
//            cell.userPortrait.image = [UIImage ;

        }
        
        return cell;
    } else if (indexPath.section == 1){
        DefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEFAULTCELL" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                cell.cellLabel.text = @"创建班级";
                cell.cellImage.image = [UIImage imageNamed:@"NOTEPAD_ADD"];
                break;
            case 1:
                cell.cellLabel.text = @"加入班级";
                cell.cellImage.image = [UIImage imageNamed:@"NOTEPAD_OK"];
                break;
            case 2:
                cell.cellLabel.text = @"班级列表";
                cell.cellImage.image = [UIImage imageNamed:@"NOTEPAD"];
                break;
            default:
                break;
        }
        return cell;
    } else  {
        DefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEFAULTCELL" forIndexPath:indexPath];
        cell.cellLabel.text = @"教师认证";
        cell.cellImage.image = [UIImage imageNamed:@"USER_ADD"];
        return cell;
    }
    

}

-(void)downloadData {
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    if (userid!=nil&&token!=nil) {
        
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/user/queryif" ];
        self.parameters = [NSDictionary dictionaryWithObject:userid forKey:@"userId"];
        
        NSLog(@"parameters :%@", self.parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [session.requestSerializer  setValue:token forHTTPHeaderField:@"token"];     //将token添加到请求头
        [session GET:self.sessionUrl parameters:self.parameters progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@",[responseObject class]);
                 //根据key获取value
                 NSNumber* status = [responseObject objectForKey:@"status"];
                 if ([status isEqualToNumber:[NSNumber numberWithInt:0]]) {
                     NSLog(@"success");
                     NSLog(@"%@",responseObject);
                     
                     self.myProfileModel = [[MyProfileModel alloc] initWithDictionary:responseObject];
                     NSLog(@"%@",self.myProfileModel);
                     [_tableView reloadData];
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"error%@",error);
             }
         ];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MyProfileViewController *myProfile = [[MyProfileViewController alloc] init];
        myProfile.myProfileModel = self.myProfileModel;
        [self pushToViewController:myProfile];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0)
        {
            CreateClassViewController* createClassVC = [[CreateClassViewController alloc] init];
            [self pushToViewController:createClassVC];
        } else if (indexPath.row == 1)
        {
            JoinClassViewController* joinClassVC = [[JoinClassViewController alloc] init];
            [self pushToViewController:joinClassVC];
        } else if (indexPath.row == 2)
        {
            ClassViewController* classVC = [[ClassViewController alloc] init];
            [self pushToViewController:classVC];
        }
    } else if (indexPath.section == 2)
    {
        TeacherConfirmViewController* confirmVC = [[TeacherConfirmViewController alloc] init];
        [self pushToViewController:confirmVC];
    }
}

-(void)pushToViewController:(UIViewController* )targetController
{
    targetController.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:targetController animated:true];
//    self.hidesBottomBarWhenPushed = false;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:false];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        //根据内容计算高度
        CGRect rect = [context boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-155, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        //     再加上其他控件的高度得到cell的高度
        
        return rect.size.height+108;
        
    } else {
        return 40;
    }
    

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
