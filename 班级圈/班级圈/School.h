//
//	School.h
//
//	Create by Jep Xia on 27/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface School : NSObject

@property (nonatomic, strong) NSString * area;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSObject * cjsort;
@property (nonatomic, assign) NSInteger classify;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * province;
@property (nonatomic, strong) NSString * school;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end