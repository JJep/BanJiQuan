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

-(void)didTouchBtn:(UIButton *)sender {
    if (sender.tag == self.likeButton.tag) {
        self.likeButton.selected = !self.likeButton.selected;
        if (self.likeButton.selected == true) {
            [self afLikeMoment:YES];
        } else {
            [self afLikeMoment:false];
        }
    }
}

-(void)afLikeMoment:(BOOL )like
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        NSString* sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/title/like" ];
        //创建多个字典
        NSDictionary* parameters = [[NSDictionary alloc] init];
        if (like) {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        userid,@"userid",
                                        userid,@"userId",
                                        0,@"deleted",
                                        self.titleId,@"titleId"
                                        , nil];
        } else {
            parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                        userid,@"userid",
                                        userid,@"userId",
                                        1,@"deleted",
                                        self.titleId,@"titleId"
                                        , nil];
        }
        
        NSLog(@"parameters :%@", parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session POST:sessionUrl
          parameters:parameters
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 NSLog(@"%@",responseObject);
                 //根据key获取value
                 NSNumber* status = [responseObject objectForKey:@"status"];
                 if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                     self.likeButton.selected = true;
                     [self updateUI];
                 } else if ([status isEqualToNumber:[NSNumber numberWithInteger:1]]) {
                     self.likeButton.selected = false;
                     [self updateUI];
                 } else if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
                     UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"操作失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                     UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                     [alertController addAction:alertAction];
                     [[self viewController] presentViewController:alertController animated:true completion:nil];
                 }
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"failure");
                 UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"操作失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                 [alertController addAction:alertAction];
                 [[self viewController] presentViewController:alertController animated:true completion:nil];
                 NSLog(@"%@", error);
             }
         ];
    }

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
    CGFloat width = (self.contentView.bounds.size.width - 60) / 3;
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
    
    if (!self.likeButton) {
        self.likeButton = [UIButton new];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"点赞红"] forState:UIControlStateSelected];
        [self.likeButton setTag:1];
        [self.likeButton addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.likeButton];

    }
    
    if (!self.shareView) {
        self.shareView = [UIView new];
        self.shareView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.shareView];
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
        if ([self.imageArray count] == 0) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        } else if ([self.imageArray count] <= 3) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + (15+width));
        } else if ([self.imageArray count] <= 6) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 2*(15+width));
        } else if ([self.imageArray count] <= 9) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 3*(15+width));
        }
        
    }];
    
    [self.CommentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.shareView);
        make.right.equalTo(self.shareView.mas_right).offset(-10);
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.CommentButton.mas_left).offset(-30);
        make.width.height.mas_equalTo(30);
        make.centerY.equalTo(self.shareView);
    }];
    
    UIView* grayView2= [UIView new];
    [self.contentView addSubview:grayView2];
    grayView2.backgroundColor = [GlobalVar grayColorGetter];
    [grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareView.mas_bottom);
        make.width.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
}

-(NSString *)handleUrl:(NSString *)url {
    NSString* str = [NSString stringWithFormat:@"http://%@:8080/bjquan/titlespic/%@", [GlobalVar urlGetter],url];
    return str;
}

-(void)loadPhoto {
    CGFloat width = (self.contentView.bounds.size.width - 60) / 3;

    
    if ([self.imageArray count] > 0) {
        if ([self.imageArray count]<=3) {
            for (int i = 0; i < [self.imageArray count]; i++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                    make.left.equalTo(self.contentView.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            if ([self.imageArray count] == 3) {
            } else {
                
            }
        } else if ([self.imageArray count] <= 6) {
            for (int i = 0; i < 3 ; i ++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                    make.left.equalTo(self.contentView.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i =3; i < [self.imageArray count]; i++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10+10+width);
                    make.left.equalTo(self.contentView.mas_left).offset(15+(i-3)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            if ([self.imageArray count] == 6) {
                
            } else {
                
            }
        } else if ([self.imageArray count] <= 9) {
            for (int i = 0; i < 3 ; i ++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
                    make.left.equalTo(self.contentView.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i =3; i < 6; i++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10+10+width);
                    make.left.equalTo(self.contentView.mas_left).offset(15+(i-3)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i = 6; i < [self.imageArray count]; i ++) {
                UIButton* imageBtn = [UIButton new];
                [self.contentView addSubview:imageBtn];
                UIImageView* imageView = [UIImageView new];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArray[i]]]];
                [imageBtn setImage:imageView.image forState:UIControlStateNormal];
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(10+2*(10+width));
                    make.left.equalTo(self.contentView.mas_left).offset(15+(i-6)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            if ([self.imageArray count] == 9) {
            } else {
                
            }
        }
    }
    
    
    [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(-1);
        make.width.equalTo(self.likeButton);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.CommentButton.mas_left).offset(-1);
        if ([self.imageArray count] == 0) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        } else if ([self.imageArray count] <= 3) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + (15+width));
        } else if ([self.imageArray count] <= 6) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 2*(15+width));
        } else if ([self.imageArray count] <= 9) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(10 + 3*(15+width));
        }
        
    }];

}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object
{
//    CGFloat statusLabelWidth =150;
//    //字符串分类提供方法，计算字符串的高度，还是同样道理，字符串有多高，cell也不需要知道，参数传给你，具体怎么算不管，字符串NSString自己算好返回来就行
//    CGSize statusLabelSize =[object sizeWithLabelWidth:statusLabelWidthfont:[UIFontsystemFontOfSize:17]];
//    return statusLabelSize.height;
    return 0;
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

-(void)updateUI {
    if (self.isLike) {
        self.likeButton.selected = true;
    }
    
    if (self.likeUsers) {
        
        UIView* grayView1 = [UIView new];
        [self.contentView addSubview:grayView1];
        [grayView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareView.mas_bottom).offset(10);
            make.left.equalTo(self.contentLabel.mas_left);
            make.right.equalTo(self.contentLabel.mas_right);
            make.height.mas_equalTo(0.7);
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
