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
@property (nonatomic,retain)UIView* shareView;
@property (nonatomic,retain)UIButton* CommentButton;
@property (nonatomic,retain)UIButton* likeButton;
@property (nonatomic,retain)NSMutableArray* imageArray;
@property (nonatomic)BOOL isLike;
@property (nonatomic,retain)NSArray* likeUsers;
@property (nonatomic,retain)NSNumber* titleId;
-(void)updateUI;
-(void)loadPhoto;
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;
-(CGFloat)hadleForHeight;
@end
