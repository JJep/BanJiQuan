//
//	Codetime.h
//
//	Create by Jep Xia on 18/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Codetime : NSObject

@property (nonatomic, assign) NSInteger date;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger nanos;
@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger timezoneOffset;
@property (nonatomic, assign) NSInteger year;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end