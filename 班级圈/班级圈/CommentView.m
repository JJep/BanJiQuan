//
//  CommentView.m
//  班级圈
//
//  Created by Jep Xia on 2017/5/1.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//
#import "GlobalVar.h"
#import "CommentView.h"
#import "Comment.h"
#import <Masonry.h>
@implementation CommentView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat labelHeight = 5 ;
    for (int i = 0; i < [self.commentsArray count]; i ++) {
        
        UIButton* commentBtn = [UIButton new];
        [commentBtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:commentBtn];
        
        Comment* comment = [[Comment alloc] initWithDictionary:self.commentsArray[i]];
        
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
            [commentBtn addSubview:commentContentLb];
            [commentContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.top.equalTo(self.mas_top).offset(labelHeight);
            }];
            labelHeight += [self handleLabelHeight:string labelFont:commentContentLb.font];
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
            [commentBtn addSubview:commentContentLb];
            [commentContentLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left);
                make.right.equalTo(self.mas_right);
                make.top.equalTo(self.mas_top).offset(labelHeight);
            }];
            labelHeight += [self handleLabelHeight:string labelFont:commentContentLb.font];
        }
        
    }
    
    self.commentViewHeight = [self heightForCommentView:labelHeight];
}

-(CGFloat)handleLabelHeight:(NSString *)labelString labelFont:(UIFont *)labelFont
{
    
    CGRect rect = [labelString boundingRectWithSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-30, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:@{NSFontAttributeName:labelFont} context:nil];

    return rect.size.height;
}

-(CGFloat)heightForCommentView:(CGFloat) commentHeight
{
    return commentHeight;
}


@end
