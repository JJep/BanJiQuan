//
//  MomentsViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/3/28.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MomentsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _tableView;
    NSArray *_persons;
    NSArray* _contentArray;

}
//-(void)afLikeMoment:(BOOL )like titleId:(NSNumber *)titleId;
@end
