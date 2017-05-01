//
//	MomentModel.h
//
//	Create by Jep Xia on 30/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Classe.h"
#import "Title.h"

@interface MomentModel : NSObject

@property (nonatomic, strong) NSArray * classes;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray * titles;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end