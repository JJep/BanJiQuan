//
//  jggView.m
//  班级圈
//
//  Created by Jep Xia on 2017/5/1.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "jggView.h"
#import "GlobalVar.h"
@implementation jggView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat width = (self.bounds.size.width - 60 )/ 3;
    
    if ([self.imageArrays count] > 0) {
        if ([self.imageArrays count]<=3) {
            for (int i = 0; i < [self.imageArrays count]; i++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10);
                    make.left.equalTo(self.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
        } else if ([self.imageArrays count] <= 6) {
            for (int i = 0; i < 3 ; i ++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10);
                    make.left.equalTo(self.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i =3; i < [self.imageArrays count]; i++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10+10+width);
                    make.left.equalTo(self.mas_left).offset(15+(i-3)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
        } else if ([self.imageArrays count] <= 9) {
            for (int i = 0; i < 3 ; i ++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10);
                    make.left.equalTo(self.mas_left).offset(15+i*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i =3; i < 6; i++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10+10+width);
                    make.left.equalTo(self.mas_left).offset(15+(i-3)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
            for (int i = 6; i < [self.imageArrays count]; i ++) {
                UIImageView* imageView = [UIImageView new];
                [self addSubview:imageView];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self handleUrl:self.imageArrays[i]]]];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(10+2*(10+width));
                    make.left.equalTo(self.mas_left).offset(15+(i-6)*(15+width));
                    make.width.height.mas_equalTo(width);
                }];
            }
        }
    }
}

-(NSString *)handleUrl:(NSString *)url {
    NSString* str = [NSString stringWithFormat:@"http://%@/bjquan/titlespic/%@", [GlobalVar urlGetter],url];
    return str;
}
@end
