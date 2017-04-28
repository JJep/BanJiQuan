//
//  NewMomentViewController.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/23.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMomentViewController : UIViewController
@property (nonatomic,retain)UITextView* txText;
@property (nonatomic,retain)UIButton* chooseImageBtn;
@property (nonatomic,retain)UIButton* chooseClass;
@property (nonatomic,retain)UIButton* addVoice;
@property (nonatomic,retain)UIImageView* image;
@property (nonatomic,retain)NSMutableArray* selectedClasses;
@property (nonatomic,retain)NSArray* imageArr;
@end
