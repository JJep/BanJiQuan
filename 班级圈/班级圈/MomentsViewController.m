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
#import "Comment.h"
#import "SendCommentView.h"
#import <MJRefresh.h>

@interface MomentsViewController () <UITextFieldDelegate>
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSMutableArray* classes;
@property (nonatomic,retain)NSMutableArray* momentArray;
@property (nonatomic,retain)NSMutableArray* cellHeightArray;
@property (nonatomic,retain)NSMutableArray* likeUsers;
@property (nonatomic,retain)NSMutableArray* likeUsersViewHeight;
@property (nonatomic,retain)NSMutableArray* commentsViewHeight;
@property (nonatomic,retain)NSMutableArray *textFieldArray ;
@property (nonatomic,retain)SendCommentView *sendCommentView;
@property (nonatomic,retain)UITextField* textField;
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
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/qallf10" ];
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
//                     _momentArray = [responseObject objectForKey:@"titles"];
                     [self.momentArray addObjectsFromArray:[responseObject objectForKey:@"titles"]];
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

-(void)afPostCommentOnMomment:(NSInteger)sender
{
    
    [self.textField resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/postcomment" ];
        //创建多个字典
        Title* moment = [[Title alloc] initWithDictionary:[self.momentArray objectAtIndex:sender]];
        
        NSDictionary* parameters ;
        
        parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                      userid,@"userid",
                      userid,@"userId",
                      moment.tag,@"tagc",
                      self.textField.text,@"content",
                      [NSNumber numberWithInteger:moment.idField],@"titleid",
                      nil];
        
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
                  NSLog(@"%@", [responseObject objectForKey:@"title"]);
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                      
                      [self.momentArray replaceObjectAtIndex:sender withObject:[responseObject objectForKey:@"title"]];
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:1]]) {

                      NSLog(@"%@", [NSNumber numberWithInteger: sender]);
                      [self.momentArray replaceObjectAtIndex:sender withObject:[responseObject objectForKey:@"title"]];
                      
                      
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
                      
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

-(void)afPostCommentOnComment:(UIButton *)sender WithToUserId:(NSInteger )toUserId
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/postcomment" ];
        //创建多个字典
        Title* moment = [[Title alloc] initWithDictionary:[self.momentArray objectAtIndex:sender.tag]];
        
//        Comment *comment = [[Comment alloc] initWithDictionary:moment.comments];
        NSDictionary* parameters ;

            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          userid,@"userid",
                          userid,@"userId",
                          @"",@"content",
                          [NSNumber numberWithInteger:moment.idField],@"titleid"
                          , nil];
        
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
                  NSLog(@"%@", [responseObject objectForKey:@"title"]);
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                      
                      //                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:sender.tag-1];
                      //                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      [self.momentArray replaceObjectAtIndex:sender.tag withObject:[responseObject objectForKey:@"title"]];
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                      //                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
                      //                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      NSLog(@"%@", [NSNumber numberWithInteger: sender.tag]);
                      [self.momentArray replaceObjectAtIndex:sender.tag withObject:[responseObject objectForKey:@"title"]];
                      
                      
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
                      //                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
                      //                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      
                      
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

-(void)afLikeMoment:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/like" ];
        //创建多个字典
        Title* moment = [[Title alloc] initWithDictionary:[self.momentArray objectAtIndex:sender.tag]];
        NSDictionary* parameters ;
        if (sender.selected) {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          userid,@"userid",
                          userid,@"userId",
                          @0,@"deleted",
                          moment.tag,@"tagl",
                          [NSNumber numberWithInteger:moment.idField],@"titleid"
                          , nil];
        } else {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                          userid,@"userid",
                          userid,@"userId",
                          @1,@"deleted",
                          moment.tag,@"tagl",
                          [NSNumber numberWithInteger:moment.idField],@"titleid"
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
                  NSLog(@"%@", [responseObject objectForKey:@"title"]);
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                      
//                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:sender.tag-1];
//                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      [self.momentArray replaceObjectAtIndex:sender.tag withObject:[responseObject objectForKey:@"title"]];
                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
//                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
//                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      NSLog(@"%@", [NSNumber numberWithInteger: sender.tag]);
                      [self.momentArray replaceObjectAtIndex:sender.tag withObject:[responseObject objectForKey:@"title"]];
                      

                  } else if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
//                      self.likeUsers = [[NSArray arrayWithObject:[responseObject objectForKey:@"like"]] objectAtIndex:0];
//                      [self.likeUsers replaceObjectAtIndex:sender.tag-1 withObject:[responseObject objectForKey:@"like"]];
                      

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

-(void)downloadMoreMoments
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];

    if (userid) {

        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/qafter10" ];
        //创建多个字典
        Title* lastMoment = [[Title alloc] initWithDictionary:[self.momentArray objectAtIndex:[self.momentArray count]-1]];
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid,@"userId",
                           [NSNumber numberWithInteger:lastMoment.idField],@"id",
                           nil];
        
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
//                     self.classes = [responseObject objectForKey:@"classes"];
                     NSLog(@"%@", self.classes);
//                     [self.momentArray addObjectsFromArray:[responseObject objectForKey:@"titles"]];
                     for (int i = 0; i < [[responseObject objectForKey:@"titles"] count]; i++) {
                         [self.momentArray insertObject:[[responseObject objectForKey:@"titles"] objectAtIndex:i]   atIndex:[self.momentArray count]];
                     }
//                     [self.momentArray insertObjects:[responseObject objectForKey:@"titles"] atIndexes:[self.momentArray count]];
                     [_tableView reloadData];
                     [_tableView.mj_footer endRefreshing];
                 } else {
                     [_tableView.mj_footer endRefreshing];

                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"failure");
                 NSLog(@"%@", error);
                 [_tableView.mj_footer endRefreshing];
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
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/title/qallf10" ];
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
                     
//                     [defaults setObject:self.classes forKey:@"classesArray"];
//                     _momentArray = [responseObject objectForKey:@"titles"];
//                     [self.momentArray addObject:[responseObject objectForKey:@"titles"]];
                     if ([self.momentArray isEqualToArray:[responseObject objectForKey:@"titles"]]) {
                         
                     } else {
                         [self.momentArray removeAllObjects];
                         [self.momentArray addObjectsFromArray:[responseObject objectForKey:@"titles"]];
                     }
                     [_tableView reloadData];
                     [_tableView.mj_header endRefreshing];
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"failure");
                 NSLog(@"%@", error);
                 [_tableView.mj_header endRefreshing];
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

-(void)commentOnMoment:(UIButton *)sender
{
    NSLog(@"点击了评论按钮");

    self.sendCommentView.tag = sender.tag;
    [self.textField becomeFirstResponder];
//    self.sendCommentView.sendBtn.tag = sender.tag;
    
}

//键盘即将出现的时候
- (void)keyboardWillShow:(NSNotification *)sender{
    
    CGRect keyboardRect = [(sender.userInfo[UIKeyboardFrameBeginUserInfoKey]) CGRectValue];
    //改变bttomView的y值，防止被键盘遮住
    CGRect bottomViewRect = self.sendCommentView.frame;
    bottomViewRect.origin.y = self.view.frame.size.height - keyboardRect.size.height - bottomViewRect.size.height;
    self.sendCommentView.frame = bottomViewRect;
    
    [self.sendCommentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view.mas_bottom).offset(-keyboardRect.size.height);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textField resignFirstResponder];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"should return");
    [self afPostCommentOnMomment:self.sendCommentView.tag];
    
    return YES;
}

//键盘即将消失的时候
- (void)keyboardWillHidden:(NSNotification *)sender{
    
    [self.sendCommentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
}


-(void) initSendCommentView
{


    self.sendCommentView = [SendCommentView new];
//    self.sendCommentView.textField.delegate = self;
    [self.sendCommentView.textField setHidden:true];
    
    self.sendCommentView.backgroundColor = [GlobalVar grayColorGetter];
    [self.view addSubview:self.sendCommentView];
    [self.sendCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(50);
    }];
        //textField遵循协议

    
    self.textField = [UITextField new];
    [self.sendCommentView addSubview:self.textField];
    self.textField.layer.cornerRadius = 5;
    self.textField.placeholder = @"发表评论";
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    //    self.sendBtn.layer.cornerRadius = 5;

    //    [self addSubview:self.sendBtn];
    
    //    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.mas_left).offset(20);
    //        make.top.equalTo(self.mas_top).offset(10);
    //        make.bottom.equalTo(self.mas_bottom).offset(-10);
    //        make.right.equalTo(self.sendBtn.mas_left).offset(-20);
    //    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendCommentView.mas_left).offset(20);
        make.right.equalTo(self.sendCommentView.mas_right).offset(-20);
        make.top.equalTo(self.sendCommentView).offset(10);
        make.bottom.equalTo(self.sendCommentView).offset(-10);
    }] ;
    

}

-(void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    _tableView.backgroundColor = [GlobalVar grayColorGetter];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UIAccessibilityTraitNone;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //    _tableView.tableFooterView.hidden = false;
    [self.view addSubview:_tableView];
    
    
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"MOMENTCELL"];
    [_tableView registerClass:[MomentsHeadTableViewCell class] forCellReuseIdentifier:@"HEADCELL"];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self downloadMoments];
        
    }];
    
    // Enter the refresh status immediately
    [_tableView.mj_header beginRefreshing];
    
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self downloadMoreMoments];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:@"UIKeyboardWillHideNotification" object:nil];

    
    //tableview不被tabbar遮盖
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    self.textFieldArray = [[NSMutableArray alloc] init];
    self.likeUsersViewHeight = [[NSMutableArray alloc] init];
    self.commentsViewHeight = [[NSMutableArray alloc] init];
    self.likeUsers = [[NSMutableArray alloc] init];
    self.momentArray = [[NSMutableArray alloc] init];
    
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setupNavigationBar];
//    [self downloadMoments];
    [self initTableView];
    [self initSendCommentView];

    self.navigationItem.title = @"全部关注";

}
-(void)didTouchSend:(NSInteger )momentId
{
    
}

-(void)popClassView
{
    
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
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return [self.momentArray count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MomentsHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HEADCELL" forIndexPath:indexPath];
        cell.backgroundImage.image = [UIImage imageNamed:@"flower.jpg"];
        cell.nameLabel.text = @"陈小艺的家长";
        [cell.userPortraitImage setImage:[UIImage imageNamed:@"头像大"]];
        cell.userInteractionEnabled = NO;
        return cell;
    } else {
        //这里用CustomCell替换原来的UITableViewCell
//        CustomTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MOMENTCELL" forIndexPath:indexPath];
        CustomTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MOMENTCELL"];
        }
        if ([self.momentArray count]>0) {
            Title* moment = [[Title alloc ] initWithDictionary:[self.momentArray objectAtIndex:indexPath.row]];
            NSLog(@"%@", moment);
            User* user = [[User alloc] initWithDictionary:[moment.user toDictionary]];
            if (moment.likes) {
                [self.likeUsers insertObject:moment.likes atIndex:indexPath.row];
            }
////->->->->->->->->->->->->->->->->->->为每一个cell配置一个textfield<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-
//            //为每一个cell配置一个textfield
//            SendCommentView *sendCommentView = [SendCommentView new];
//            sendCommentView.textField.delegate = self;
//            [self.textFieldArray addObject:sendCommentView];
//            [self.view addSubview:sendCommentView];
//            [sendCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_bottom);
//                make.width.equalTo(self.view);
//                make.centerX.equalTo(self.view);
//                make.height.mas_equalTo(50);
//            }];
//            [sendCommentView.sendBtn setTag:indexPath.row];
//            [sendCommentView.sendBtn addTarget:self action:@selector(afPostCommentOnMomment:) forControlEvents:UIControlEventTouchUpInside];
//            
////******************************************************************************************************
            cell.contentLabel.text = moment.content;
            cell.titleId = [NSNumber numberWithInteger:moment.idField];
            if (moment.pics) {
                NSArray *pics = [(NSString *)moment.pics componentsSeparatedByString:@";"];
                if ([pics isEqualToArray:cell.imageArray]) {
                } else {
                    [cell loadPhotoWithModel:pics];
                    cell.imageArray = [NSMutableArray arrayWithArray:pics];
                }
            }
            
////******************************************************************************************************
            if ([cell.likeUsers isEqualToArray:moment.likes]) {
            } else {
                [cell loadLikeUsersWithModel:moment.likes];
            }

            NSLog(@"%@",moment.comments);
            if ([cell.comments isEqualToArray:moment.comments]) {
                
            } else {
               [cell loadCommentWithModel:moment.comments];
            }

//******************************************************************************************************
            if (user.username) {
                cell.nameLabel.text = (NSString *)user.username;
            }
            
//            [cell.userPortraitImage setImage:[UIImage imageNamed:@"头像中"]];
 
            [cell.userPortraitImage sd_setImageWithURL:[GlobalVar handleUrl:(NSString *)moment.user.head] placeholderImage:[UIImage imageNamed:@"userPortrait.jpg"]];
            
            if (moment.createtime) {
                cell.timeLabel.text = [self timeWithTimeIntervalString:[NSString stringWithFormat: @"%ld", (long)moment.createtime]];;
            }
            
            cell.likeButton.tag = indexPath.row;
            [cell.likeButton addTarget:self action:@selector(LikeMoment:) forControlEvents:UIControlEventTouchUpInside];
            [cell.CommentButton addTarget:self action:@selector(commentOnMoment:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 180;
    } else {
    //根据内容计算高度
        CGFloat iconHeight = 0;
        if ([self.momentArray count] > 0) {
            Title* moment = [[Title alloc] initWithDictionary:[self.momentArray objectAtIndex:indexPath.row]];
            iconHeight += [CustomTableViewCell rowHeightForMoment:moment];
        
        }
        NSLog(@"section = %@, row = %@, height = %@",[NSNumber numberWithInteger:indexPath.section],[NSNumber numberWithInteger:indexPath.row],[NSNumber numberWithFloat: iconHeight]);
        return iconHeight;
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
