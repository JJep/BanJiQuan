//
//  CustomTableViewCell.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/6.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (nonatomic,retain)UILabel* nameLabel; //显示名字
@property (nonatomic,retain)UILabel* timeLabel;
@property (nonatomic,retain)UIImageView* userPortraitImage;
@property (nonatomic,retain)UILabel* contentLabel;
@property (nonatomic,retain)UIButton* shareButton;
@property (nonatomic,retain)UIButton* CommentButton;
@property (nonatomic,retain)UIButton* likeButton;
@property (nonatomic,retain)UIImageView* images;
@end
