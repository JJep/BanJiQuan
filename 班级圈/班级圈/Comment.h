//
//	Comment.h
//
//	Create by Jep Xia on 1/5/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "User.h"

@interface Comment : NSObject

@property (nonatomic, strong) NSString * content;
@property (nonatomic, assign) NSInteger createtime;
@property (nonatomic, strong) User * fromuser;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger titleid;
@property (nonatomic, strong) User * touser;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
