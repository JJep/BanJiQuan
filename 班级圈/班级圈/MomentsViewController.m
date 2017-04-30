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
#import "VoiceMomentViewController.h"

@interface MomentsViewController ()
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSMutableArray* classes;
@property (nonatomic,retain)NSMutableArray* MomentArray;
@property (nonatomic,retain)NSMutableArray* cellHeightArray;
@property (nonatomic,retain)NSArray* likeUsers;
@end

@implementation MomentsViewController

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    // 3.发送请求
    
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
                 // 3. 结束刷新
                 [control endRefreshing];
                 
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"failure");
                 NSLog(@"%@", error);
                 [control endRefreshing];

             }
         ];
    }
}

-(void)afLikeMoment:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/title/like" ];
        //创建多个字典
        NSDictionary* parameters ;
        if (sender.selected) {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          userid,@"userid",
                          userid,@"userId",
                          @0,@"deleted",
                          [NSNumber numberWithInteger:sender.tag],@"titleid"
                          , nil];
        } else {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          userid,@"userid",
                          userid,@"userId",
                          @1,@"deleted",
                          [NSNumber numberWithInteger:sender.tag],@"titleid"
                          , nil];
        }
        
        NSLog(@"parameters :%@", parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session POST:sessionUrl
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"%@",responseObject);
                  //根据key获取value
                  NSNumber* status = [responseObject objectForKey:@"status"];
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
                      UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"操作失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                      UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                      [alertController addAction:alertAction];
                      [self presentViewController:alertController animated:true completion:nil];
                  }
                  [_tableView reloadData];
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"failure");
                  UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"操作失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                  UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:alertAction];
                  [self presentViewController:alertController animated:true completion:nil];
                  
                  NSLog(@"%@", error);
              }
         ];
    }
    
}


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


-(void)LikeMoment:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self afLikeMoment:sender];
}

-(void)popClassView
{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //tableview不被tabbar遮盖
    
//    self.cellHeight = 180;
    
    _contentArray = [NSArray arrayWithObjects: @"膜方面哇哦皮肤内外哦发那位 i 哦放牛娃分别为 i 奥放牛娃发你哦完肥哦无法 i 哦服务你哦发哇分为发膜方面哇哦皮肤内外哦发那位 i 哦放牛娃分别为 i 奥放牛娃", @"发你哦完肥哦无法 i 哦服务你哦发哇分为发膜方面哇哦皮肤内外哦发那位 i 哦放牛娃分别为 i 奥放牛娃发你哦完肥哦无法 i 哦服务你哦发哇分为发膜方面哇哦皮肤内外哦发那位 i 哦放牛娃分别为 i 奥放牛娃发你哦完肥哦无法 i 哦服务你哦发哇分为发膜方面哇哦皮肤内外哦发那位 i 哦放牛娃分别为 i 奥放牛娃", nil];
    
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //    self.view.backgroundColor = [GlobalVar grayColorGetter];
    [self setupNavigationBar];
    [self downloadMoments];
    [self setupRefresh];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _tableView.backgroundColor = [GlobalVar grayColorGetter];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UIAccessibilityTraitNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _tableView.tableFooterView.hidden = false;
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
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultMomentAction = [UIAlertAction actionWithTitle:@"发送图文动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NewMomentViewController* newMomentVC = [[NewMomentViewController alloc] init];
        [self pushToTargetVC:newMomentVC];
    }];
    [alertController addAction:defaultMomentAction];
    UIAlertAction* voiceMomentAction = [UIAlertAction actionWithTitle:@"发送音频动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        VoiceMomentViewController* voiceMomentVC = [[VoiceMomentViewController alloc] init];
        [self pushToTargetVC:voiceMomentVC];
    }];
    [alertController addAction:voiceMomentAction];
    UIAlertAction* videoMomentAction = [UIAlertAction actionWithTitle:@"发送视频动态" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:videoMomentAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    

}

-(void)pushToTargetVC:(UIViewController* )targetVC
{
    targetVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:targetVC animated:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.MomentArray count]+1;
//    return [_contentArray count] + 1;
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
        cell.titleId = [NSNumber numberWithInteger:moment.idField];
//        cell.titleId = [NSNumber numberWithInteger:1];
//        cell.likeUsers = [NSArray arrayWithObjects:@"Jep!",@"Jep!",@"Jep!",@"Jep!",@"Jep!", nil];
        if (moment.pics) {
            
            NSArray *pics = [(NSString *)moment.pics componentsSeparatedByString:@";"];
            cell.imageArray = [NSMutableArray arrayWithArray:pics];
        }
        
        if (user.username) {
            cell.nameLabel.text = (NSString *)user.username;
        }
        
        [cell.userPortraitImage setImage:[UIImage imageNamed:@"头像中"]];
        if (moment.createtime) {
            cell.timeLabel.text = [self timeWithTimeIntervalString:[NSString stringWithFormat: @"%ld", (long)moment.createtime]];;
        }
        cell.contentLabel.text = moment.content;
        cell.likeButton.tag = moment.idField;
//        cell.likeUsers = self.likeUsers;
        [cell.likeButton addTarget:self action:@selector(LikeMoment:) forControlEvents:UIControlEventTouchUpInside];
//        
//        cell.nameLabel.text = @"Jep!";
//        cell.timeLabel.text = @"5分钟前";
//        cell.contentLabel.text = [_contentArray objectAtIndex:indexPath.row-1];
//        
//        [cell loadPhoto];
//        [cell updateUI];
        [cell configUI];
        return cell;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 180;
    } else {
    //根据内容计算高度
        CGFloat iconHeight = 160;
        CGRect rect = [[[self.MomentArray objectAtIndex:indexPath.row-1] objectForKey:@"text"] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-30, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];  
//     再加上其他控件的高度得到cell的高度
        Title* moment = [[Title alloc] initWithDictionary:[self.MomentArray objectAtIndex:indexPath.row-1]];
        if (moment.pics) {
            
            NSArray *pics = [(NSString *)moment.pics componentsSeparatedByString:@";"];
            CGFloat width = (self.view.bounds.size.width -60 )/3;
            if ([pics count] == 0) {
                return 30 + iconHeight;
            }
            else if ([pics count] <= 3) {
                return rect.size.height + width+30 + iconHeight;
            } else if ([pics count] <= 6) {
                return (15 + 2*(15+width) + rect.size.height + iconHeight);
            } else {
                return (15 + 3*(15+width) + rect.size.height + iconHeight);
            }
        } else {
            return rect.size.height+ iconHeight;
        }
        
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
