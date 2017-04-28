//
//  MeViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/3/28.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
}

@end
