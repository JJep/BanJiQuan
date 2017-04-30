//
//  LikeUsersView.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/30.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "LikeUsersView.h"
#import <Masonry.h>
#import "GlobalVar.h"
@implementation LikeUsersView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIView* assistView1 = [UIView new];
    assistView1.backgroundColor = [GlobalVar grayColorGetter];
    [self addSubview:assistView1];
    
    UILabel* likeUsersLabel = [UILabel new];
    likeUsersLabel.font = [UIFont systemFontOfSize:15];
    likeUsersLabel.text = self.likeUsersName;
    likeUsersLabel.textColor = [GlobalVar themeColorGetter];
    likeUsersLabel.numberOfLines = 0;
    [self addSubview:likeUsersLabel];
    
    UIImageView* likeImage = [UIImageView new];
    likeImage.image = [UIImage imageNamed:@"点赞红"];
    [self addSubview:likeImage];
    
    [assistView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.centerX.equalTo(self);
        make.height.mas_offset(1);
    }];
    
    [likeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.height.mas_equalTo(30);
        make.top.equalTo(assistView1.mas_bottom).offset(5);
    }];
    
    [likeUsersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(assistView1.mas_bottom).offset(5);
    }];
    
    
    
}


@end
