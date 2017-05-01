//
//	SchoolList.h
//
//	Create by Jep Xia on 20/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface SchoolList : NSObject

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * school;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end