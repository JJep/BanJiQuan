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
    assistView1.backgroundColor = [UIColor whiteColor];
    [self addSubview:assistView1];
    self.backgroundColor = [UIColor whiteColor];
    self.likeUsersLabel = [UILabel new];
    self.likeUsersLabel.font = [UIFont systemFontOfSize:15];
    self.likeUsersLabel.text = self.likeUsersName;
    self.likeUsersLabel.textColor = [GlobalVar themeColorGetter];
    self.likeUsersLabel.numberOfLines = 0;
    [self addSubview:self.likeUsersLabel];
    
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
        make.width.height.mas_equalTo(15);
        make.top.equalTo(assistView1.mas_bottom).offset(5);
    }];
    
    [self.likeUsersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(assistView1.mas_bottom).offset(5);
    }];
    self.likeUsersLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    [self.likeUsersLabel layoutIfNeeded];
//    [self.likeUsersLabel setNeedsLayout];
    
}

+(CGFloat)heightForLikeUserNameLabel:(NSString *) likeUsersName{
    CGRect rect = [likeUsersName boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-40, MAXFLOAT)
                                                                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
//    [self.likeUsersLabel layoutIfNeeded];
//    [self layoutSubviews];
    return rect.size.height;
}

@end
