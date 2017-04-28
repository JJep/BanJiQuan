//
//  EditProfileTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/25.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "EditProfileTableViewCell.h"
#import <Masonry.h>
@implementation EditProfileTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
    
}

-(void)configUI
{
    
    UIImageView* arrowImg = [UIImageView new];
    [self.contentView addSubview:arrowImg];
    self.cellKey = [UILabel new];
    [self.contentView addSubview:self.cellKey];
    self.cellValue = [UILabel new];
    [self.contentView addSubview:self.cellValue];
    self.cellImage = [UIImageView new];
    [self.contentView addSubview:self.cellImage];

    
    self.cellKey.text = @"cellKey";

    [self.cellKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-100);
    }];
    
    
    self.cellValue.text = @"cellValue";
    self.cellValue.textColor = [UIColor grayColor];
    self.cellValue.font = [UIFont systemFontOfSize:15];
    [self.cellValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).offset(-8);
        make.centerY.equalTo(self.contentView);

    }];
    

    [arrowImg setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(self.cellValue);
        make.width.mas_equalTo(8);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg).offset(-8);
        make.height.width.mas_equalTo(60);
        make.top.equalTo(self.contentView).offset(4);
        make.centerY.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-4);
    }];

    
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
