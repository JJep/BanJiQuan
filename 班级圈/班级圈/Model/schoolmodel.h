//
//	schoolmodel.h
//
//	Create by Jep Xia on 27/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "School.h"

@interface schoolmodel : NSObject

@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, strong) School * school;
@property (nonatomic, assign) NSInteger status;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end