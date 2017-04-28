//
//  MeHeadTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/12.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "MeHeadTableViewCell.h"
#import <Masonry.h>

@implementation MeHeadTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    
    if (!self.arrow)
    {
        self.arrow = [UIImageView new];
        [self.arrow setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
        [self.contentView addSubview:self.arrow];
        
        //初始化设置约束
        [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(22);
        }];
    }
    
    if(!self.userPortrait)
    {
        self.userPortrait = [UIImageView new];
        [self.userPortrait setImage:[UIImage imageNamed:@"userPortrait.jpg"]];
        [self.contentView addSubview:self.userPortrait];
        
        [self.userPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.and.height.mas_equalTo(72);
        }];
    }
    
    if(!self.userName)
    {
        self.userName = [UILabel new];
        self.userName.text = @"Jep!";
        [self.contentView addSubview:self.userName];
        
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(22);
            make.left.equalTo(self.userPortrait.mas_right).with.offset(20);
            make.right.equalTo(self.arrow.mas_left).with.offset(-20);
            make.height.mas_equalTo(22);
        }];
        
    }
    
    if(!self.userPhoneNumber)
    {
        self.userPhoneNumber = [UILabel new];
        self.userPhoneNumber.text = @"187******10";
        [self.contentView addSubview:self.userPhoneNumber];
        
        [self.userPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userName.mas_bottom).offset(10);
            make.left.equalTo(self.userName.mas_left);
//            make.bottom.equalTo(self.userDescription.mas_top).offset(-10);
            make.right.equalTo(self.arrow.mas_left).offset(-20);
            make.height.mas_equalTo(22);
        }];
    }
    
    if(!self.userDescription)
    {
        self.userDescription = [UILabel new];
        self.userDescription.text = @"这个人懒得要死，啥都不写";
        self.userDescription.numberOfLines = 0;
        
        [self.contentView addSubview:self.userDescription];
        [self.userDescription mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userPhoneNumber.mas_bottom).offset(10);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-22);
            make.left.equalTo(self.userName.mas_left);
            make.right.equalTo(self.arrow.mas_left).offset(-10);
        }];
    }
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
