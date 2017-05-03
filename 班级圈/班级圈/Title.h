//
//	Title.h
//
//	Create by Jep Xia on 30/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "User.h"

@interface Title : NSObject

@property (nonatomic, assign) NSInteger classid;
@property (nonatomic, strong) NSArray * comments;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger createtime;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSArray * likes;
@property (nonatomic, strong) NSString * pics;
@property (nonatomic, strong) User * user;
@property (nonatomic, strong) NSString * tag;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
