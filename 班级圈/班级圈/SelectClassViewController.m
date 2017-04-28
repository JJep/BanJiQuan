//
//  SelectClassViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/23.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "SelectClassViewController.h"
#import <Masonry.h>
#import "Classe.h"
#import "GlobalVar.h"
#import "NewMomentViewController.h"
@interface SelectClassViewController ()
{
    UIScrollView* _scrollView;
}
@end

@implementation SelectClassViewController

-(void)createUI
{
    
    for (int i = 0; i < [self.classes count]; i ++) {
        UIButton* button = [UIButton new];
        Classe* class = [[Classe alloc] initWithDictionary:[self.classes objectAtIndex:i]];
        
        [button setTag:class.idField];
        UILabel* lbClassName = [UILabel new];
        UIImageView* nikeImage = [UIImageView new];
        [button addSubview:nikeImage];
        [button addSubview:lbClassName];
        [nikeImage setImage:[UIImage imageNamed:@"nike.jpeg"]];
        button.selected = false;
        
        [nikeImage setHidden:true];
        lbClassName.text = class.name;
        lbClassName.textColor = [GlobalVar blueColorGetter];
        [_scrollView addSubview:button];
        
        [lbClassName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button).offset(10);
            make.right.equalTo(button).offset(-40);
            make.centerY.equalTo(button);
        }];
        
        [nikeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(button).offset(-10);
            make.width.mas_equalTo(22);
            make.height.mas_equalTo(40);
            make.centerY.equalTo(button);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.top.width.centerX.equalTo(_scrollView);
            } else {
                make.top.equalTo(_scrollView.mas_top).offset(i*(15+54));
                make.width.centerX.equalTo(_scrollView);
            }
            make.height.mas_equalTo(54);
        }];
        
        [button addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }

}

-(void)didTouchBtn:(UIButton *)sender
{
    if (sender.tag == -1) {
        NewMomentViewController* newMomentVC = [[NewMomentViewController alloc] init];
        [newMomentVC.selectedClasses addObjectsFromArray:self.selectedClasses];
        [self.navigationController popViewControllerAnimated:true];
    } else {
        sender.selected = !sender.selected;
        
        UIButton *view= nil;
        NSArray *subviews= [_scrollView subviews];
        for (view in subviews)
        {
            if ([view isKindOfClass:[UIButton class]] && view.tag == sender.tag)
            {
                [self.selectedClasses addObject:[NSNumber numberWithInteger:sender.tag]];
                UIImageView* nikeImg = nil;
                NSArray *buttonSubviews = [view subviews];
                if (sender.selected == true) {
                    for (nikeImg in buttonSubviews) {
                        if ([nikeImg isKindOfClass:[UIImageView class]]) {
                            [nikeImg setHidden:false];
                        }
                    }
                } else if (sender.selected == false) {
                    [self.selectedClasses removeObject:[NSNumber numberWithInteger:sender.tag]];
                    for (nikeImg in buttonSubviews) {
                        if ([nikeImg isKindOfClass:[UIImageView class]]) {
                            [nikeImg setHidden:true];
                        }
                    }
                }
            }
            
        }
    }
    
}

-(void)didTouchNavigationItem:(UIBarButtonItem* )sender
{
    
    //此页面已经存在于self.navigationController.viewControllers中,并且是当前页面的前一页面
    
    NewMomentViewController *power= [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    //初始化其属性
    
    power.selectedClasses = nil;
    
    //传递参数过去
    
    power.selectedClasses = [NSMutableArray arrayWithArray:self.selectedClasses];
    
    //使用popToViewController返回并传值到上一页面
    
    [self.navigationController popToViewController:power animated:YES];
    
}

-(void)initScrollView
{
    // 1.创建UIScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*2);
    _scrollView.frame = self.view.bounds; // frame中的size指UIScrollView的可视范围
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:_scrollView];
    
    // 隐藏水平滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = NO;
    

}

-(void)initNavigation{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedClasses = [[NSMutableArray alloc] init];
    
    [self initNavigation];

    self.view.backgroundColor = [UIColor grayColor];
    NSLog(@"%@", self.classes);
    
    [self initScrollView];
    [self createUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action: @selector(didTouchNavigationItem:)];
    [self.navigationItem.rightBarButtonItem setTag:-10];
//    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
