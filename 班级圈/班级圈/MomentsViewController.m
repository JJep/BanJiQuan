//
//  MomentsViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/28.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "MomentsViewController.h"
#import "CustomTableViewCell.h"
#import "MomentsHeadTableViewCell.h"
#import "GlobalVar.h"
#import <AFNetworking.h>
#import "Title.h"
#import "User.h"
#import "NewMomentViewController.h"
@interface MomentsViewController ()
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSMutableArray* classes;
@property (nonatomic,retain)NSMutableArray* MomentArray;

@end

@implementation MomentsViewController

-(void)downloadMoments
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/title/qallf10" ];
        //创建多个字典
        self.parameters = [NSDictionary dictionaryWithObject:userid forKey:@"userId"];
        
        NSLog(@"parameters :%@", self.parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session GET:self.sessionUrl
          parameters:self.parameters
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@",responseObject);
                 //根据key获取value
                 NSNumber* status = [responseObject objectForKey:@"status"];
                 if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                     
                     self.classes = [responseObject objectForKey:@"classes"];
                     NSLog(@"%@", self.classes);
                     
                     
                     self.MomentArray = [responseObject objectForKey:@"titles"];
                     
                     
                     [_tableView reloadData];
        
                 }
                 
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"failure");
                 NSLog(@"%@", error);
             }
         ];
    }

}

-(void)didTouchBtn:(UIButton *)sender
{
    if (sender.tag == 10) {
        [self popClassView];
    }
}

-(void)popClassView
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self downloadMoments];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UIAccessibilityTraitNone;

    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [_tableView registerClass:[MomentsHeadTableViewCell class] forCellReuseIdentifier:@"HEADCELL"];
    
    self.navigationItem.title = @"全部关注";
//    self.tabBarItem.title = [NSString stringWithFormat:@"Discover"];
}

-(void)setupNavigationBar
{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(20, 20, 100, 40);
    [button setTag:10];
    [button setTitle:@"全部关注" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage* Img = [UIImage imageNamed:@"新建消息"];
    Img = [Img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:Img style:UIBarButtonItemStyleDone target:self action:@selector(didTouchNavigationItem:)];
    [self.navigationItem.rightBarButtonItem setTag:-10];

    
    self.navigationItem.titleView = button;
}

-(void)didTouchNavigationItem:(UINavigationItem*) sender
{
    NewMomentViewController* newMomentVC = [[NewMomentViewController alloc] init];
    [self.navigationController pushViewController:newMomentVC animated:true];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.MomentArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MomentsHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HEADCELL" forIndexPath:indexPath];
        cell.backgroundImage.image = [UIImage imageNamed:@"flower.jpg"];
        cell.nameLabel.text = @"陈小艺的家长";
        [cell.userPortraitImage setImage:[UIImage imageNamed:@"头像大"]];
        cell.userInteractionEnabled = NO;
        return cell;
    } else {
        //这里用CustomCell替换原来的UITableViewCell
        Title* moment = [[Title alloc] initWithDictionary:[self.MomentArray objectAtIndex:indexPath.row-1]];
        User* user = [[User alloc] initWithDictionary:[moment.user toDictionary]];
        
        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        [cell.images setImage:[UIImage imageNamed:@"flower.JPG"]];
        
        if (user.username) {
            cell.nameLabel.text = (NSString *)user.username;
        }
        
        [cell.userPortraitImage setImage:[UIImage imageNamed:@"头像中"]];
        if (moment.createtime) {
            cell.timeLabel.text = [self timeWithTimeIntervalString:[NSString stringWithFormat: @"%ld", (long)moment.createtime]];;
        }
        cell.contentLabel.text = moment.content;
        cell.contentLabel.numberOfLines = 0;
        cell.userInteractionEnabled = NO;
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 180;
    } else {
    //根据内容计算高度
     CGRect rect = [_contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-100, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];  
//     再加上其他控件的高度得到cell的高度
    
     return rect.size.height+250;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
//#pragma mark -- 计算宽窄的函数
//-(float)autoCalculateWidthOrHeight:(float)height
//                             width:(float)width
//                          fontsize:(float)fontsize
//                           content:(NSString*)content
//{
//    //计算出rect
//    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, height)
//                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
//    
//    //判断计算的是宽还是高
//    if (height == MAXFLOAT) {
//        return rect.size.height;
//    }
//    else
//        return rect.size.width;
//}
//
@end
