//
//	NewMomentModel.h
//
//	Create by Jep Xia on 23/4/2017
//	Copyright © 2017. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Classe.h"

@interface NewMomentModel : NSObject

@property (nonatomic, strong) NSArray * classes;
@property (nonatomic, assign) NSInteger status;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end