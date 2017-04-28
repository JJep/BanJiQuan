//
//  MomentsHeadTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/6.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "MomentsHeadTableViewCell.h"
#import "GlobalVar.h"
@implementation MomentsHeadTableViewCell


-(UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180)];
        _backgroundImage.backgroundColor = [GlobalVar themeColorGetter];
        [self.contentView addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

-(UIImageView *)userPortraitImage
{
    if (!_userPortraitImage) {
        _userPortraitImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 63, 72, 72)];
        [self.contentView addSubview:_userPortraitImage];
    }
    return _userPortraitImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+self.userPortraitImage.bounds.size.width+24, 92, self.bounds.size.width, 30)];
        _nameLabel.font = [UIFont systemFontOfSize:20];
        _nameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
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
