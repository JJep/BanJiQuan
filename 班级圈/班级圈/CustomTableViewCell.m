//
//  CustomTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/6.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <Masonry.h>

@implementation CustomTableViewCell


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
    if (!self.userPortraitImage) {
        self.userPortraitImage = [UIImageView new];
        [self.contentView addSubview:self.userPortraitImage];
        [self.userPortraitImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(37.5);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(10.5);
        }];
    }
    
    if (!self.nameLabel) {
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPortraitImage.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10.5);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.mas_equalTo(20);
        }];
    }
    
    if (!self.timeLabel) {
        self.timeLabel = [UILabel new];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.timeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPortraitImage.mas_right).offset(10);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(6);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    
    if(!self.contentLabel) {
        self.contentLabel = [UILabel new];
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:17];
        //        _contenLabel.backgroundColor = [UIColor colorWithRed:109/255.0 green:211/255.0 blue:206/255.0 alpha:1];
        
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPortraitImage.mas_left);
            make.top.equalTo(self.userPortraitImage.mas_bottom).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
        }];
        
        
//        //根据cell重新调整label的高度
//        CGRect labelRect = _contentLabel.frame;
//        labelRect.size.height = CGRectGetHeight(self.frame)-55-60;
//        _contentLabel.frame = labelRect;
    }
    
    if(!self.images){
        self.images  = [UIImageView new];
        [self.contentView addSubview:self.images];
        
        [self.images mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel.mas_left);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
            make.width.height.mas_equalTo(110);
            
        }];
    }
    
    if (!self.likeButton) {
        self.likeButton = [UIButton new];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.likeButton];

    }
    
    if (!self.shareButton) {
        self.shareButton = [UIButton new];
        [self.shareButton setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.shareButton];
    }
    
    if (!self.CommentButton) {
        self.CommentButton = [UIButton new];
        [self.CommentButton setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.CommentButton];
    }
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(-1);
        make.width.equalTo(self.likeButton);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.CommentButton.mas_left).offset(-1);
        make.top.equalTo(self.images.mas_bottom).offset(10);
    }];
    
    [self.CommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.likeButton);
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(self.shareButton);
        make.top.equalTo(self.shareButton.mas_top);
        
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(1);
        make.height.equalTo(self.shareButton.mas_height);
        make.width.equalTo(self.CommentButton);
        make.left.equalTo(self.CommentButton.mas_right).offset(1);
        make.top.equalTo(self.shareButton.mas_top);
    }];
    
    for (int i=0 ; i < 4; i++) {
        UIView* view = [UIView new];
        [self.contentView addSubview:view];
        view.backgroundColor = [UIColor grayColor];
        if (i == 0) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.shareButton.mas_top);
                make.width.equalTo(self.contentView);
                make.left.equalTo(self.contentView);
                make.height.mas_equalTo(1);
            }];
        }
        if (i == 1) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shareButton.mas_right);
                make.right.equalTo(self.CommentButton.mas_left);
                make.height.bottom.top.equalTo(self.shareButton);
            }];
        }
        if (i == 2) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.CommentButton.mas_right);
                make.right.equalTo(self.likeButton.mas_left);
                make.height.top.bottom.equalTo(self.CommentButton);
            }];
        }
        if (i == 3) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shareButton.mas_bottom);
                make.width.equalTo(self.contentView);
                make.left.equalTo(self.contentView);
                make.height.mas_equalTo(1);
            }];
        }
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
