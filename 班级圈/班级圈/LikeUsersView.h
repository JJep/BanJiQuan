//
//  LikeUsersView.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/30.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeUsersView : UIView
@property (nonatomic,retain)NSArray* likeUsers;
@property (nonatomic,retain)NSString* likeUsersName;
@property (nonatomic,retain)NSString* content;
@property (nonatomic,retain)UILabel* likeUsersLabel;
-(CGFloat)heightForLikeUserNameLabel;


@end
