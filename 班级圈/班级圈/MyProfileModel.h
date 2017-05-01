//
//	MyProfileModel.h
//
//	Create by Jep Xia on 18/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "User.h"

@interface MyProfileModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) User * user;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end