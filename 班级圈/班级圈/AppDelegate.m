//
//  AppDelegate.m
//  班级圈
//
//  Created by Jep Xia on 2017/3/27.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "AppDelegate.h"
#import "MomentsViewController.h"
#import "ChatViewController.h"
#import "ScheduleViewController.h"
#import "MeViewController.h"
#import "Login.h"
#import "Register.h"
#import <RongIMKit/RongIMKit.h>
#import "TestConversationViewController.h"
#import <AFNetworking.h>
#import "GlobalVar.h"
#import "UIImagePickerViewController.h"
#import "School.h"
@interface AppDelegate ()
@property (strong, nonatomic) NSDictionary* parameters;
@property (strong, nonatomic) NSDictionary* qmatchParameters;
@property (strong, nonatomic) School* school;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[RCIM sharedRCIM] initWithAppKey:@"pvxdm17jpgirr"];
    [self autoLogin];
    [self qmatch];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    MomentsViewController* moments = [[MomentsViewController alloc] init];
    moments.view.backgroundColor = [UIColor blueColor];
    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:moments];
    nav1.tabBarItem.title = @"fwa";
//    nav1.title = @"fawwawa";
    nav1.navigationBar.barTintColor = [GlobalVar themeColorGetter];
    [nav1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [nav1.navigationBar setTintColor:[UIColor whiteColor]];

    
    ChatViewController* chat = [[ChatViewController alloc] init];
    chat.view.backgroundColor = [UIColor yellowColor];
    chat.title = @"Classes";
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:chat];
    nav2.navigationBar.barTintColor = [GlobalVar themeColorGetter];
    [nav2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [nav2.navigationBar setTintColor:[UIColor whiteColor]];

    
    Login* schedule = [[Login alloc] init];
    schedule.view.backgroundColor = [UIColor orangeColor];
    schedule.title = @"Schedule";
    UINavigationController* nav3 = [[UINavigationController alloc] initWithRootViewController:schedule];
    nav3.navigationBar.barTintColor = [GlobalVar themeColorGetter];
    [nav3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [nav3.navigationBar setTintColor:[UIColor whiteColor]];

    MeViewController* me = [[MeViewController alloc] init];
    me.view.backgroundColor = [UIColor greenColor];
    me.title = @"Me";
    UINavigationController* nav4 = [[UINavigationController alloc] initWithRootViewController:me];
    nav4.navigationBar.barTintColor = [GlobalVar themeColorGetter];
    [nav4.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    [nav4.navigationBar setTintColor:[UIColor whiteColor]];
    UITabBarController* tbController = [[UITabBarController alloc] init];
    NSArray* arrayVC = [NSArray arrayWithObjects:nav1,
                                                 nav2,
                                                 nav3,
                                                 nav4,
                                                 nil];
    tbController.viewControllers = arrayVC ;
    tbController.hidesBottomBarWhenPushed = YES;
    
    self.window.rootViewController = tbController;
    [self.window makeKeyAndVisible];
    
    
    
    //rongyun
    
    return YES;
}

-(void)qmatch
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSLog(@"%@", token);
    
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    
    NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/class/qmatch" ];
    //创建多个字典
    if (userid!=nil&&token!=nil) {
        NSDictionary* parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                    userid,@"uid",
                                    userid,@"userId",
                                    nil];
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session GET:sessionUrl parameters:parameters progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  //根据key获取value
                  NSNumber* status = [responseObject objectForKey:@"status"];
                  int myInt = [status intValue];
                  if (myInt == 0) {
                      if ([[responseObject objectForKey:@"flag"] isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                          self.school = [[School alloc] initWithDictionary:[responseObject objectForKey:@"school"]];
                          [defaults setObject:[NSNumber numberWithInteger:self.school.idField] forKey:@"schoolId"];
                          [defaults setObject:self.school.city forKey:@"schoolCity"];
                          [defaults setObject:self.school.area forKey:@"schoolArea"];
                          [defaults setObject:[NSNumber numberWithInteger:self.school.classify] forKey:@"schoolClass"];
                          [defaults setObject:self.school.school forKey:@"schoolName"];
                          [defaults setObject:[responseObject objectForKey:@"flag"] forKey:@"teacherFlag"];
                          [defaults setObject:[NSNumber numberWithInteger:self.school.idField] forKey:@"schooldId"];
                          NSLog(@"%@", [defaults objectForKey:@"teacherFlag"]);
                          NSLog(@"schoolDict = %@", [defaults objectForKey:@"schoolDict"]);
                          
                      } else {
                          [defaults setObject:[responseObject objectForKey:@"flag"] forKey:@"teacherFlag"];
                      }
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"failure");
                  NSLog(@"%@", error);
              }
         ];
        
    }
}

-(void)autoLogin
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSLog(@"token = %@", token);
    
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    
    NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/user/autologin" ];
    //创建多个字典
    if (userid!=nil&&token!=nil) {
        NSDictionary* parameters = [NSDictionary dictionaryWithObject:userid forKey:@"userId"];
        NSLog(@"parameters :%@", self.parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session POST:sessionUrl parameters:parameters progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  //根据key获取value
                  NSNumber* status = [responseObject objectForKey:@"status"];
                  int myInt = [status intValue];
                  if (myInt == 0) {
                      
                      NSLog(@"登录成功");
                      
                  } else if (myInt == 1)
                  {
                      //UIAlertController风格：UIAlertControllerStyleAlert
                      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录已过期，请重新登录！"
                                                                                               message:nil
                                                                                        preferredStyle:UIAlertControllerStyleAlert ];
                      
                      //添加取消到UIAlertController中
                      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                      [alertController addAction:cancelAction];
                      
                      //添加确定到UIAlertController中
                      UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                      [alertController addAction:OKAction];
                      
                  }
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"failure");
                  NSLog(@"%@", error);
              }
         ];
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
