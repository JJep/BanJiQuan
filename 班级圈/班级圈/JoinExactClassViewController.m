//
//  CreateClassViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/17.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "JoinExactClassViewController.h"
#import <Masonry.h>
#import "CreateClassSubView.h"
#import <AFNetworking.h>
#import "GlobalVar.h"
#import "Region.h"
#import "SchoolList.h"
#import "SchoolCreateClass.h"
#import "CustomTableViewCell.h"

//    classifys = ["youeryuan/","gaozhong/","chuzhong/","daxue/","chengrenjiaoyu/","peixunjigou/"]

@interface JoinExactClassViewController () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSDictionary* pickerList;
@property (nonatomic,retain)NSArray* proTimeList;
@property (nonatomic,retain)UIPickerView* pickerView;
@property (nonatomic,retain)UIView* pickerTopView;
@property (nonatomic,retain)Region* RegionModel;
@property (nonatomic,retain)NSArray* provinceArray;
@property (nonatomic,retain)NSArray* cityArray;
@property (nonatomic,retain)NSString* selectedCity;
@property (nonatomic,retain)NSDictionary* regionDict;
@property (nonatomic,retain)NSArray* classifyArray;
@property (nonatomic,retain)NSString* selectedClass;
@property (nonatomic,retain)SchoolList* selectedSchool;
@property (nonatomic,retain)NSNumber* cellTag;
@property (nonatomic,retain)NSArray* districtArray;
@property (nonatomic,retain)NSString* selectedDistrict;
@property (nonatomic,retain)NSArray* schoolArray;
@property (nonatomic,retain)SchoolCreateClass* schoolList;
@property (nonatomic,retain)SchoolList* school;
@property (nonatomic,retain)NSArray* organizeClassArray;
@property (nonatomic,retain)NSString* selectedOrganizeClass;
@property (nonatomic,retain)UIButton* joinClass;

@end

@implementation JoinExactClassViewController

-(void)uploadJoinClass
{
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/class/create" ];
    //创建多个字典
    self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                       @1, @"schoolid",
                       @"name", @"name",
                       @2,@"userid",
                       nil];
    
    NSLog(@"parameters :%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    [session POST:self.sessionUrl parameters:self.parameters progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"%@",responseObject);
              //根据key获取value
              NSNumber* status = [responseObject objectForKey:@"status"];
              if (status==0) {
                  NSLog(@"success");
                  //UIAlertController风格：UIAlertControllerStyleAlert
                  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有标题的标题"
                                                                                           message:@"学无止境，漫漫长路"
                                                                                    preferredStyle:UIAlertControllerStyleAlert ];
                  
                  //添加取消到UIAlertController中
                  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:cancelAction];
                  
                  //添加确定到UIAlertController中
                  UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                  [alertController addAction:OKAction];
                  
                  [self presentViewController:alertController animated:YES completion:nil];
              }
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"failure");
              NSLog(@"%@", error);
          }
     ];
}

-(void)downloadDistrict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/school/qth" ];
    if (self.leftBtn.selected == true) {
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid,@"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:self.kindView.value]],@"classify",
                           self.cityView.value,@"city",
                           nil];
    } else if (self.rightBtn.selected == true)
    {
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid,@"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:@"培训机构"]],@"classify",
                           self.cityView.value,@"city",
                           nil];
    }
    
    NSLog(@"%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [session GET:self.sessionUrl parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        NSNumber* status = [responseObject objectForKey:@"status"];
        if ([status isEqualToNumber:[NSNumber numberWithInteger:0]] ) {
            if (self.leftBtn.selected == true) {
                self.districtArray = [responseObject objectForKey:@"list"];
                self.selectedDistrict = [self.districtArray objectAtIndex:0];
            } else if (self.rightBtn.selected == true) {
                self.organizeClassArray = [responseObject objectForKey:@"list"];
                self.selectedOrganizeClass = [self.organizeClassArray objectAtIndex:0];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void)downloadSchool
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/school/qschool" ];
    
    if (self.leftBtn.selected == true) {
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid, @"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:self.kindView.value]], @"classify",
                           self.cityView.value,@"city",
                           self.areaView.value,@"area",
                           nil];
    } else if (self.rightBtn.selected == true)
    {
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid, @"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:@"培训机构"]], @"classify",
                           self.cityView.value,@"city",
                           self.kindView.value,@"cjsort",
                           nil];
    }
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [session.requestSerializer  setValue:token forHTTPHeaderField:@"token"];     //将token添加到请求头
    [session GET:self.sessionUrl parameters:self.parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",[responseObject class]);
             //根据key获取value
             NSNumber* status = [responseObject objectForKey:@"status"];
             if ([status isEqualToNumber:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
                 
                 NSLog(@"school: %@", self.schoolList);
                 self.schoolArray = [responseObject objectForKey:@"list"];
                 self.selectedSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:0]];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error%@",error);
         }
     ];
    
}

-(void)didTouchBtn: (UIButton* )sender
{
    NSLog(@"%ld", (long)sender.tag);
    
    if (sender.tag == self.leftBtn.tag) {
        NSLog(@"%ld", (long)sender.tag);
        self.leftBtn.selected = true;
        self.rightBtn.selected = false;
        [self.organizeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kindView.mas_bottom).offset(46);
        }];
        [self updateUI];
    }
    if (sender.tag == self.rightBtn.tag) {
        self.rightBtn.selected = true;
        self.leftBtn.selected = false;
        [self.organizeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.kindView.mas_bottom).offset(1);
        }];
        [self.kindView.lbvalue setTextColor:[UIColor grayColor]];
        [self updateUI];
    }
    if(sender.tag == 2)
    {
        NSLog(@"取消");
        self.pickerView.hidden = true;
        self.pickerTopView.hidden = true;
        
    }
    if (sender.tag == 3) {
        NSLog(@"完成");
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]]) {
            self.cityView.value = self.selectedCity;\
            if (self.rightBtn.selected == true) {
                [self downloadDistrict];
            }
        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]]) {
            
            if (self.leftBtn.selected == true) {
                self.kindView.value = self.selectedClass;
                [self downloadDistrict];
            } else if (self.rightBtn.selected == true) {
                self.kindView.value = self.selectedOrganizeClass;
                [self downloadSchool];
            }
            
            
        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]]) {
            self.areaView.value = self.selectedDistrict;
            [self downloadSchool];
            
        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]]) {
            self.organizeView.value = self.selectedSchool.school;
        }
        [self updateUI];
        self.pickerView.hidden = true;
        self.pickerTopView.hidden = true;
        
    }
    if (sender.tag == self.cityView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:0]] objectAtIndex:0];
    }
    if (sender.tag == self.kindView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.kindView.value = [self.classifyArray objectAtIndex:0];
    }
    if (sender.tag == self.areaView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.areaView.value = [self.districtArray objectAtIndex:0];
        
    }
    if (sender.tag == self.organizeView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        
        //这里要进行进程控制
        
        
        
        
        
        
        self.selectedCity = [self.schoolArray objectAtIndex:0];
    }
    
    if (sender.tag == self.joinClass.tag) {
        [self uploadJoinClass];
    }
    
    
    
    
}

-(void)updateUI
{
    if (self.leftBtn.selected == true) {
        self.organizeView.key = @"学校";
        
    } else if (self.rightBtn.selected == true) {
        self.organizeView.key = @"机构";
    }
    [self.organizeView.lbkey setHidden:true];
    [self.organizeView.lbvalue setHidden:true];
    
    [self.cityView.lbkey setHidden:true];
    [self.cityView.lbvalue setHidden:true];
    
    [self.kindView.lbvalue setHidden:true];
    [self.kindView.lbkey setHidden:true];
    
    [self.areaView.lbvalue setHidden:true];
    [self.areaView.lbkey setHidden:true];
    
    [self.organizeView drawRect:self.organizeView.bounds];
    [self.cityView drawRect:self.cityView.bounds];
    [self.kindView drawRect:self.kindView.bounds];
    [self.areaView drawRect:self.areaView.bounds];
    
}

-(void)createUI
{
    self.view.backgroundColor = [GlobalVar grayColorGetter];
    UIView* leftView = [UIView new];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:leftView];
    UIView* rightView = [UIView new];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rightView];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(rightView.mas_left);
        make.height.mas_equalTo(45);
        make.width.equalTo(rightView.mas_width);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(rightView.mas_right);
        make.height.mas_equalTo(45);
        make.width.equalTo(leftView.mas_width);
    }];
    
    self.leftBtn = [UIButton new];
    [leftView addSubview:self.leftBtn];
    [self.leftBtn setTag:0];
    
    [self.leftBtn setTitle:@"学校班级" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[GlobalVar themeColorGetter] forState:UIControlStateSelected];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.selected = true;
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(leftView);
        make.width.height.equalTo(leftView);
    }];
    
    self.rightBtn = [UIButton new];
    [rightView addSubview:self.rightBtn];
    [self.rightBtn setTitle:@"培训机构" forState:UIControlStateNormal];
    [self.rightBtn setTag:1];
    [self.rightBtn setTitleColor:[GlobalVar themeColorGetter] forState:UIControlStateSelected];
    [self.rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(rightView);
        make.width.height.equalTo(rightView);
    }];
    
    self.cityView = [CreateClassSubView new];
    self.kindView = [CreateClassSubView new];
    self.areaView = [CreateClassSubView new];
    self.organizeView = [CreateClassSubView new];
    
    
    self.cityView.key = @"城市";
    self.cityView.value = @"杭州";
    [self.cityView setTag:4];
    self.cityView.backgroundColor = [UIColor whiteColor];
    [self.cityView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.kindView.key= @"类型";
    self.kindView.value = [self.classifyArray objectAtIndex:0];
    self.kindView.backgroundColor = [UIColor whiteColor];
    [self.kindView setTag:5];
    [self.kindView addTarget:self action:@selector(didTouchBtn:) forControlEvents: UIControlEventTouchUpInside];
    
    self.areaView.key = @"地区";
    self.areaView.value = @"江干区";
    [self.areaView setTag:6];
    self.areaView.backgroundColor = [UIColor whiteColor];
    [self.areaView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.leftBtn.selected == true) {
        self.organizeView.key = @"学校";
    } else if (self.rightBtn.selected == true) {
        self.organizeView.key = @"机构";
    }
    [self.organizeView setTag:7];
    self.organizeView.backgroundColor = [UIColor whiteColor];
    [self.organizeView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cityView];
    [self.view addSubview:self.kindView];
    [self.view addSubview:self.areaView];
    [self.view addSubview:self.organizeView];
    
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.equalTo(self.view.mas_width);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(leftView.mas_bottom).offset(10);
    }];
    
    [self.kindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.cityView.mas_bottom).offset(1);
    }];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.kindView.mas_bottom).offset(1);
    }];
    
    [self.organizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.areaView.mas_bottom).offset(1);
    }];
    
    UIView* classView = [UIView new];
    classView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:classView];
    [classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizeView.mas_bottom).offset(10);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
    }];
    
    UILabel* class = [UILabel new];
    class.text = @"班级";
    [classView addSubview:class];
    [class mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(classView.mas_left).offset(15);
        make.centerY.equalTo(classView.mas_centerY);
    }];
    
    self.txClassName = [UITextField new];
    self.txClassName.placeholder = @"请输入班级名称";
    [classView addSubview:self.txClassName];
    [self.txClassName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(class.mas_right).offset(50);
        make.centerY.equalTo(classView.mas_centerY);
    }];
    
    self.joinClass = [UIButton new];
    [self.joinClass setTag:100];
    [self.joinClass setTitle:@"加入班级" forState:UIControlStateNormal];
    [self.joinClass setBackgroundColor:[GlobalVar themeColorGetter]];
    self.joinClass.layer.cornerRadius = 5;
    [self.view addSubview:self.joinClass];
    [self.joinClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classView.mas_bottom).offset(50);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
}

-(void)popPickerView
{
    self.pickerView = [UIPickerView new];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.alpha = 0.7;
    [self.view addSubview:self.pickerView];
    
    self.pickerTopView = [UIView new];
    self.pickerTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pickerTopView];
    [self.pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.view.mas_width);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //here it is
    UIButton* leftBtn = [[UIButton alloc] init];
    UIButton* rightBtn = [UIButton new];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftBtn setTag:2];
    [leftBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn setTag:3];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerTopView addSubview:leftBtn];
    [self.pickerTopView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.equalTo(self.pickerTopView.mas_height);
        make.left.equalTo(self.pickerTopView.mas_left).offset(5);
        make.centerY.equalTo(self.pickerTopView.mas_centerY);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.equalTo(self.pickerTopView.mas_height);
        make.right.equalTo(self.pickerTopView.mas_right).offset(-5);
        make.centerY.equalTo(self.pickerTopView.mas_centerY);
        
    }];
    
    
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(150);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma Mark-- UIPickerViewDataSource
//pickerview 列数

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        return 2;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        return 1;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return 1;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        return 1;
    }
    
    return 0;
}

//pickerview 每列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            return [self.provinceArray count];
        }
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        return [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:row]] count];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        if (self.leftBtn.selected == true) {
            return [self.classifyArray count];
        } else if (self.rightBtn.selected == true) {
            return [self.organizeClassArray count];
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return [self.districtArray count];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        return [self.schoolArray count];
    }
    
    return 0;
    
    
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]] ) {
        return  self.view.bounds.size.width / 2;
    } else {
        return self.view.bounds.size.width-20;
    }
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            [self.pickerView reloadComponent:1];
            self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:row]] objectAtIndex:0];
            
        } else {
            
            NSInteger firstRow=[self.pickerView selectedRowInComponent:0];
            self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:firstRow]] objectAtIndex:row];
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        if (self.leftBtn.selected == true) {
            self.selectedClass = [self.classifyArray objectAtIndex:row];
        } else if (self.rightBtn.selected == true) {
            self.selectedClass = [self.organizeClassArray objectAtIndex:row];
        }
        
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        self.selectedDistrict = [self.districtArray objectAtIndex:row];
        NSLog(@"%@", self.selectedDistrict);
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]]) {
        self.selectedSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:row]];
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            return [self.provinceArray objectAtIndex:row];
        } else {
            NSInteger firstRow=[self.pickerView selectedRowInComponent:0];
            return [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:firstRow]] objectAtIndex:row];
            
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        if (self.leftBtn.selected == true) {
            return [self.classifyArray objectAtIndex:row];
        } else if (self.rightBtn.selected == true) {
            return [self.organizeClassArray objectAtIndex:row];
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return [self.districtArray objectAtIndex:row];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        SchoolList *pickerSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:row]];
        return pickerSchool.school;
    }
    
    
    
    return @"";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精确查找班级";
    // Do any additional setup after loading the view.
    //    classifys = ["youeryuan/","gaozhong/","chuzhong/","daxue/","chengrenjiaoyu/","peixunjigou/"]
    self.classifyArray = [[NSArray alloc] initWithObjects:@"幼儿园",@"高中",@"初中",@"大学",@"成人教育",@"培训机构", nil];
    
    
    NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mJson" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", jsonStr);
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    self.RegionModel = [[Region alloc] initWithDictionary:jsonDic];
    self.regionDict = jsonDic;
    
    self.provinceArray = [jsonDic allKeys];
    
    self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:0]] objectAtIndex:0];
    self.selectedClass = [self.classifyArray objectAtIndex:0];
    
    [self initNavigation];
    
    [self createUI];
    //    [self updateUI];
}

-(void)initNavigation
{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
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
