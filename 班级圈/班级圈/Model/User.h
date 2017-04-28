//
//	User.h
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface User : NSObject

@property (nonatomic, strong) NSObject * area;
@property (nonatomic, strong) NSObject * code;
@property (nonatomic, strong) NSObject * codetime;
@property (nonatomic, assign) NSInteger createtime;
@property (nonatomic, strong) NSObject * descriptionField;
@property (nonatomic, strong) NSObject * head;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * identity;
@property (nonatomic, strong) NSObject * password;
@property (nonatomic, strong) NSObject * phonenumber;
@property (nonatomic, strong) NSObject * qrcode;
@property (nonatomic, strong) NSObject * sex;
@property (nonatomic, strong) NSObject * status;
@property (nonatomic, strong) NSObject * username;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end