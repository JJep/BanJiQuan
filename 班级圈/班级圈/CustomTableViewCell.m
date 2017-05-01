//
//  CustomTableViewCell.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/6.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <Masonry.h>
#import "GlobalVar.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking.h>
#import "LikeUsersView.h"
#import "User.h"

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


- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)configUI
{
    self.contentView.backgroundColor = [UIColor whiteColor];
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
        
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPortraitImage.mas_left);
            make.top.equalTo(self.userPortraitImage.mas_bottom).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
//            make.width.lessThanOrEqualTo(self.contentView.bounds.size.width );
        }];
        
        
//        //根据cell重新调整label的高度
//        CGRect labelRect = _contentLabel.frame;
//        labelRect.size.height = CGRectGetHeight(self.frame)-55-60;
//        _contentLabel.frame = labelRect;
    }
    
    if (!self.shareView) {
        self.shareView = [UIView new];
        self.shareView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.shareView];
    }
    
    if (!self.likeButton) {
        self.likeButton = [UIButton new];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞红"] forState:UIControlStateSelected];
        [self.likeButton setSelected:false];
        [self.likeButton setTag:1];
        [self.shareView addSubview:self.likeButton];

    }

    if (!self.CommentButton) {
        self.CommentButton = [UIButton new];
        [self.CommentButton setImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
        [self.shareView addSubview:self.CommentButton];
    }
    

    
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.shareView);
        make.right.equalTo(self.shareView.mas_right).offset(-10);
    }];
    
    [self.CommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeButton.mas_left).offset(-30);
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.shareView);
    }];
    
    UIView* bottomView = [UIView new];
    [self.contentView addSubview:bottomView];
    bottomView.backgroundColor = [GlobalVar grayColorGetter];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.centerX.width.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];

}

-(CGFloat)loadLikeUsersWithModel:(NSArray* )likeUsers
{
    self.likeUsers = likeUsers;
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    for (int i = 0; i < [likeUsers count] ; i++) {
        User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
        if ([userid isEqualToNumber:[NSNumber numberWithInteger:user.idField]] ) {
            self.isLike = YES;
            self.likeButton.selected = true;
        }
    }

    if ([likeUsers count] > 0) {
        self.likeUsersView = [LikeUsersView new];
        NSString* likeUsersNameString ;
        for (int i = 0; i < [likeUsers count]; i++) {
            
            if (i == [likeUsers count] -1 ) {
                if (i == 0) {
                    User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                    likeUsersNameString = [NSString stringWithFormat:@"%@",user.username];
                } else {
                    User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                    likeUsersNameString = [NSString stringWithFormat:@"%@%@",likeUsersNameString,user.username];
                }
            } else {
                User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                likeUsersNameString = [NSString stringWithFormat:@"%@%@、", likeUsersNameString,user.username];
            }
        }
        
        self.likeUsersView.likeUsersName = likeUsersNameString;
        self.likeUsersView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.likeUsersView];
        [self.likeUsersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareView.mas_bottom).offset(10);
            make.left.right.equalTo(self.contentLabel);
            make.height.mas_equalTo([self.likeUsersView heightForLikeUserNameLabel]+10);
            
        }];
        NSLog(@"%@", [NSNumber numberWithFloat: [self.likeUsersView heightForLikeUserNameLabel]]);
        return [self.likeUsersView heightForLikeUserNameLabel];
    } else {
        [self.likeUsersView setHidden:true];
    }
    return 0;
}

-(CGFloat)loadCommentWithModel:(NSArray *)comments
{
    self.comments = comments;
    if ([comments count] > 0) {
        self.commentView = [CommentView new];
        [self.contentView addSubview:self.commentView];
        
        self.commentView.backgroundColor = [UIColor whiteColor];
        self.commentView.commentsArray = comments;
        
        [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.likeUsersView.mas_bottom).offset(10);
            make.height.mas_equalTo(self.commentView.commentViewHeight+ 10 );
        }];
        return self.commentView.commentViewHeight+10;
    } else {
        [self.commentView setHidden:true];
    }
    return 0;
}


-(void)loadPhotoWithModel:(NSArray* )imageArrays
{
    
    CGFloat width = (self.contentView.bounds.size.width - 60) / 3;

    [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView.mas_right);
        if ([imageArrays count] == 0) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        } else if ([imageArrays count] <= 3) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + (15+width));
        } else if ([imageArrays count] <= 6) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 2*(15+width));
        } else if ([imageArrays count] <= 9) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 3*(15+width));
        }
        
    }];
    
    self.jggView = [jggView new];
    self.jggView.imageArrays = imageArrays;
    [self.contentView addSubview:self.jggView];
    [self.jggView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.shareView.mas_bottom).offset(10);
        if ([imageArrays count] == 0) {
            make.height.mas_equalTo(0);
        } else if ([imageArrays count] <= 3) {
            make.top.mas_equalTo(10);
        } else if ([imageArrays count] <= 6) {
            make.top.mas_equalTo(10+(width+10));
        } else if ([imageArrays count] <= 9) {
            make.top.mas_equalTo(10+2*(width+10));
        }
    }];
}



- (float)getAutoCellHeight {

    [self layoutIfNeeded];

    /**
     *    self.最底部的控件.frame.origin.y      为自适应cell中的最后一个控件的Y坐标
     *    self.最底部的空间.frame.size.height   为自适应cell中的最后一个控件的高
     *    marginHeight    为自适应cell中的最后一个控件的距离cell底部的间隙
     */
    return  self.shareView.frame.origin.y + self.shareView.frame.size.height + 10;

}

-(NSString *)handleUrl:(NSString *)url {
    NSString* str = [NSString stringWithFormat:@"http://%@/bjquan/titlespic/%@", [GlobalVar urlGetter],url];
    return str;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
    CGFloat statusLabelWidth =150;
//    //字符串分类提供方法，计算字符串的高度，还是同样道理，字符串有多高，cell也不需要知道，参数传给你，具体怎么算不管，字符串NSString自己算好返回来就行
    CGSize statusLabelSize =[object sizeWithLabelWidth:statusLabelWidth font:[UIFont systemFontOfSize:17]];
    return statusLabelSize.height;
//    return 0;
}

-(CGFloat)hadleForHeight
{
    CGFloat width = (self.contentView.bounds.size.width -60 )/3;
    if ([self.imageArray count] == 0) {
        return 30;
    }
    else if ([self.imageArray count] <= 3) {
        return width+30;
    } else if ([self.imageArray count] <= 6) {
        return (15 + 2*(15+width));
    } else {
        return (15 + 3*(15+width));
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
