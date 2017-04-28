//
//	Title.h
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "User.h"

@interface Title : NSObject

@property (nonatomic, strong) NSObject * avThumbnails;
@property (nonatomic, assign) NSInteger classid;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger createtime;
@property (nonatomic, strong) NSObject * deleted;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * picThumbnails;
@property (nonatomic, strong) NSObject * pics;
@property (nonatomic, strong) User * user;
@property (nonatomic, strong) NSObject * userid;
@property (nonatomic, strong) NSObject * videos;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end