//
//  ClassView.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/24.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "ClassView.h"
#import <Masonry.h>

@implementation ClassView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIScrollView* scrollView = [[UIScrollView alloc] init];
    // 1.创建UIScrollView
    scrollView = [[UIScrollView alloc] init];
//    scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height*2);
    [scrollView setContentSize:CGSizeMake(0, self.bounds.size.height)];
    scrollView.frame = self.bounds; // frame中的size指UIScrollView的可视范围
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    [self addSubview:scrollView];
    
    // 隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceHorizontal = NO;
    
    CGFloat width = self.bounds.size.width/4-60;
    CGFloat height = 30;
    for (int i = 0; i < [self.classes count]; i++) {
        UIButton* button = [[UIButton alloc] init];
        [scrollView addSubview:button];
        if (i%4 == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(20);
                make.height.mas_equalTo(height);
                make.width.mas_equalTo(width);
            }];
        }
        if (i%4 == 1) {
//            [button mas_makeConstraints:]
        }
    }
    
}

@end
