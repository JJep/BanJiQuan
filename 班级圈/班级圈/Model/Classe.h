//
//	Classe.h
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Classe : NSObject

@property (nonatomic, strong) NSObject * announcement;
@property (nonatomic, strong) NSObject * createtime;
@property (nonatomic, strong) NSObject * head;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSObject * invitation;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSObject * qrcode;
@property (nonatomic, strong) NSObject * root;
@property (nonatomic, strong) NSObject * schoolid;
@property (nonatomic, strong) NSObject * tag;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end