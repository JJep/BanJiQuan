//
//  TestConversationViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/10.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "TestConversationViewController.h"

@interface TestConversationViewController ()

@end

@implementation TestConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //新建一个聊天会话View Controller对象,建议这样初始化
    TestConversationViewController *chat = [[TestConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE
                                                                                                   targetId:@"1"];
    
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = @"2";
    
    //设置聊天会话界面要显示的标题
    chat.title = @"想显示的会话标题";
    //显示聊天会话界面
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
