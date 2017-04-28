//
//  DefaultTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/26.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "DefaultTableViewCell.h"
#import <Masonry.h>
@implementation DefaultTableViewCell


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

-(void)configUI{
    
    UIImageView* arrow = [UIImageView new];
    [self.contentView addSubview:arrow];
    arrow.image = [UIImage imageNamed:@"ARROW_RIGHT拷贝"];
    
    if (!self.cellImage) {
        self.cellImage = [UIImageView new];
        [self.contentView addSubview:self.cellImage];
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(20);
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    if (!self.cellLabel) {
        
        self.cellLabel = [UILabel new];
        [self.contentView addSubview:self.cellLabel];
        [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cellImage.mas_right).offset(20);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(arrow.mas_left).offset(-20);
        }];
    }
    

    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(12);
        make.centerY.equalTo(self.contentView);
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
