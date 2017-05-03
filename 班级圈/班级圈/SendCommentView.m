//
//  SendCommentView.m
//  班级圈
//
//  Created by Jep Xia on 2017/5/2.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "SendCommentView.h"
#import <Masonry.h>
#import "GlobalVar.h"
@implementation SendCommentView 


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.textField = [UITextField new];
//    self.sendBtn = [UIButton new];
//    self.textField.layer.cornerRadius = 5;
//    self.textField.placeholder = @"发表评论";
//    self.textField.borderStyle = UITextBorderStyleRoundedRect;
//    
////    self.sendBtn.layer.cornerRadius = 5;
//    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [self.sendBtn setTitleColor:[GlobalVar themeColorGetter] forState:UIControlStateNormal];
//    [self addSubview:self.textField];
////    [self addSubview:self.sendBtn];
//    
////    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(self.mas_left).offset(20);
////        make.top.equalTo(self.mas_top).offset(10);
////        make.bottom.equalTo(self.mas_bottom).offset(-10);
////        make.right.equalTo(self.sendBtn.mas_left).offset(-20);
////    }];
//    
//    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(20);
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.top.equalTo(self).offset(10);
//        make.bottom.equalTo(self).offset(-10);
//    }] ;
//    
//    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.equalTo(self.mas_top).offset(10);
////        make.bottom.equalTo(self.mas_bottom).offset(-10);
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.width.mas_equalTo(70);
//        make.height.equalTo(self.textField);
//        make.centerY.equalTo(self);
//    }];
    
    
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


@end
