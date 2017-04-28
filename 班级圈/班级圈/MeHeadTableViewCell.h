//
//  MeHeadTableViewCell.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/12.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeHeadTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView* userPortrait;
@property (nonatomic,retain)UIImageView* arrow;
@property (nonatomic,retain)UILabel* userName;
@property (nonatomic,retain)UILabel* userPhoneNumber;
@property (nonatomic,retain)UILabel* userDescription;
@end
