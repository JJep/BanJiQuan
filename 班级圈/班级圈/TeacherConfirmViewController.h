//
//  TeacherConfirmViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/26.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateClassSubView.h"
@interface TeacherConfirmViewController : UIViewController
@property (nonatomic,retain)CreateClassSubView* cityView;
@property (nonatomic,retain)CreateClassSubView* kindView;
@property (nonatomic,retain)CreateClassSubView* areaView;
@property (nonatomic,retain)CreateClassSubView* organizeView;
@end
