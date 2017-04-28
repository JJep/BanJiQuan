//
//  CreateClassSubView.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/17.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "CreateClassSubView.h"
#import <Masonry.h>

@implementation CreateClassSubView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.lbkey = [UILabel new];
    self.lbvalue = [UILabel new];
//    self.lbkey.text = @"key";
//    self.lbvalue.text = @"value";
    self.lbkey.textColor = [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1];
    UIImageView* arrow = [UIImageView new];
    [arrow setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    self.lbkey.text = self.key;
    self.lbvalue.text = self.value;
    [self addSubview:arrow];
    [self addSubview:self.lbvalue];
    [self addSubview:self.lbkey];
    
    [self.lbkey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.lbvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbkey.mas_right).offset(50);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(22);
    }];
    
    
    
}


@end
