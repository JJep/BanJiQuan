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
#import "Comment.h"

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
            make.width.height.mas_equalTo(35);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
    }
    
    if (!self.nameLabel) {
        self.nameLabel = [UILabel new];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.userPortraitImage.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
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
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.userPortraitImage.mas_bottom).offset(10);
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
    self.commentView = [CommentView new];
    [self.contentView addSubview:self.commentView];
    self.likeUsersView = [LikeUsersView new];
    [self.contentView addSubview:self.likeUsersView];
    self.jggView = [jggView new];
    [self.contentView addSubview:self.jggView];
    
    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    
    [self.likeUsersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(0);
        
    }];

    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.likeUsersView.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    
}

-(CGFloat)loadLikeUsersWithModel:(NSArray* )likeUsers
{
    
    self.likeUsersView.backgroundColor = [UIColor grayColor];
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

    //将likeusers拼接成新的字符串
    if ([likeUsers count] > 0) {
        [self.likeUsersView setHidden:false];
        NSString* likeUsersNameString ;
        for (int i = 0; i < [likeUsers count]; i++) {
            
            if (i == 0) {
                User *user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                likeUsersNameString = [NSString stringWithFormat:@"%@",user.username];
            } else {
                if (i == [likeUsers count] - 1) {
                    User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                    likeUsersNameString = [NSString stringWithFormat:@"%@%@",likeUsersNameString,user.username];
                } else {
                    User* user = [[User alloc] initWithDictionary:[likeUsers objectAtIndex:i]];
                    likeUsersNameString = [NSString stringWithFormat:@"%@%@、", likeUsersNameString,user.username];
                }
            }
        }
        
        self.likeUsersView.likeUsersName = likeUsersNameString;
        self.likeUsersView.backgroundColor = [UIColor whiteColor];
        [self.likeUsersView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo([LikeUsersView heightForLikeUserNameLabel:likeUsersNameString]);
            
        }];
        return [LikeUsersView heightForLikeUserNameLabel:likeUsersNameString];
    } else {
        [self.likeUsersView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareView.mas_bottom).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.height.mas_equalTo(0);
        }];
        [self.likeUsersView setHidden:true];
    }
    return 0;
}

-(CGFloat)loadCommentWithModel:(NSArray *)comments
{
    self.comments = comments;

    self.commentView.backgroundColor = [UIColor redColor];
    
    if ([comments count] > 0) {
        [self.commentView setHidden:false];
        [self.contentView addSubview:self.commentView];
        
        self.commentView.backgroundColor = [UIColor whiteColor];
        self.commentView.commentsArray = comments;
        
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.likeUsersView.mas_bottom).offset(10);
            make.height.mas_equalTo(self.commentView.commentViewHeight+ 10 );
        }];
        return self.commentView.commentViewHeight+10;
    } else {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.top.equalTo(self.likeUsersView.mas_bottom).offset(10);
            make.height.mas_equalTo(0);
        }];
        [self.commentView setHidden:true];
    }
    return 0;
}


-(void)loadPhotoWithModel:(NSArray* )imageArrays
{
    
    self.jggView.backgroundColor = [UIColor orangeColor];
    self.imageArray = imageArrays;
    
    CGFloat width = (self.contentView.bounds.size.width - 60) / 3;

    [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.contentView.mas_right);
        if ([imageArrays count] == 0) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(25);
        } else if ([imageArrays count] <= 3) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(25 + (15+width));
        } else if ([imageArrays count] <= 6) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(25 + 2*(15+width));
        } else if ([imageArrays count] <= 9) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(25 + 3*(15+width));
        }
        
    }];
    

    self.jggView.imageArrays = imageArrays;
    self.jggView.backgroundColor = [UIColor whiteColor];
    [self.jggView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        if ([imageArrays count] == 0) {
            make.height.mas_equalTo(10);
        } else if ([imageArrays count] <= 3) {
            make.height.mas_equalTo(10+(width+10));
        } else if ([imageArrays count] <= 6) {
            make.height.mas_equalTo(10+2*(width+10));
        } else if ([imageArrays count] <= 9) {
            make.height.mas_equalTo(10+3*(width+10));
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

+(CGFloat)rowHeightForMoment:(Title *)moment
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 60 )/ 3;
    CGFloat rowHeight = 120;
    //计算contentLabelde的高度
    if (moment.content) {
        CGRect rect = [moment.content boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-30, MAXFLOAT)
                                                                                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        rowHeight += rect.size.height;
    }
    
    //计算photoView的高度
    NSArray *imageArray = [(NSString *)moment.pics componentsSeparatedByString:@";"];
    if ([imageArray count] > 0) {
        if ([imageArray count] <= 3) {
            rowHeight += width + 15;
        } else if ([imageArray count] <= 6) {
            rowHeight += 2* (width + 15);
        } else if ([imageArray count] <= 9) {
            rowHeight += 3* (width + 15);
        }
    } else {
        rowHeight += 0;
    }

    //计算likeUsersView的高度
    
    //将likeusers拼接成新的字符串
    NSArray *likeUsers = moment.likes;
    if ([likeUsers count] > 0) {
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
        rowHeight += ([LikeUsersView heightForLikeUserNameLabel:likeUsersNameString] + 10);
    }
    
    //计算commentView的height
    NSArray *commentsArray = moment.comments;
    if ([commentsArray count] > 0) {
        CGFloat labelHeight = 10 ;
        for (int i = 0; i < [commentsArray count]; i ++) {
            
            Comment* comment = [[Comment alloc] initWithDictionary:commentsArray[i]];
            
            if (comment.touser.idField) {
                /*对用户的评论*/
                UILabel* commentContentLb = [UILabel new];
                //设置label的字体大小
                //            commentContentLb.font = [UIFont systemFontOfSize:15];
                //将评论人跟评论内容拼接为一个字符串
                NSString* string = [NSString stringWithFormat:@"%@回复%@：%@",(NSString *)comment.fromuser.fusername,(NSString *)comment.touser.username, comment.content];
                NSMutableAttributedString *commentContentString = [[NSMutableAttributedString alloc] initWithString:string];
                //设置评论人的名字的字体颜色为 主题色
                [commentContentString addAttribute:NSForegroundColorAttributeName value:[GlobalVar themeColorGetter] range:NSMakeRange(0,[(NSString *)comment.fromuser.fusername length] )];
                [commentContentString addAttribute:NSForegroundColorAttributeName value:[GlobalVar themeColorGetter] range:NSMakeRange([(NSString *)comment.fromuser.fusername length]+2,[(NSString *)comment.touser.username length] )];
                commentContentLb.attributedText = commentContentString;
                //对label布局

                //            labelHeight += [self handleLabelHeight:string labelFont:commentContentLb.font];
                labelHeight += [CommentView handleLabelHeight:string labelFont:commentContentLb.font];
            } else {
                /*对该朋友圈的评论*/
                
                UILabel* commentContentLb = [UILabel new];
                //设置label的字体大小
                //            commentContentLb.font = [UIFont systemFontOfSize:15];
                //将评论人跟评论内容拼接为一个字符串
                NSString* string = [NSString stringWithFormat:@"%@：%@",(NSString *)comment.fromuser.fusername, comment.content];
                NSMutableAttributedString *commentContentString = [[NSMutableAttributedString alloc] initWithString:string];
                //设置评论人的名字的字体颜色为 主题色
                [commentContentString addAttribute:NSForegroundColorAttributeName value:[GlobalVar themeColorGetter] range:NSMakeRange(0,[(NSString *)comment.fromuser.fusername length] )];
                commentContentLb.attributedText = commentContentString;
                //对label布局

                //            labelHeight += [self handleLabelHeight:string labelFont:commentContentLb.font];
                labelHeight += [CommentView handleLabelHeight:string labelFont:commentContentLb.font];
            }
            
        }
        rowHeight += labelHeight;

    }
    return rowHeight;
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
