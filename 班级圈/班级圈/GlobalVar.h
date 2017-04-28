//
//  GlobalVar.h
//  班级圈
//
//  Created by Jep Xia on 2017/4/10.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GlobalVar : NSObject
+(void)strSetter:(NSString *) str;
+(NSString *) urlGetter;
+(UIColor *) blueColorGetter;
+(UIColor *) themeColorGetter;
+(NSArray *) provinceArrayGetter;
+(NSDictionary *) regionDictGetter;
+(NSArray *)classifyArrayGetter;
+(UIColor *)grayColorGetter;
@end
