//
//  GlobalVar.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/10.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "GlobalVar.h"
#import <UIKit/UIKit.h>
#import "Region.h"
@implementation GlobalVar
static NSString* url = @"192.168.88.24";
//static UIColor* blueColor = nil;
//if ( == nil)
//localArray = [NSArray arrayWithArray: self.container.objects ];
+(void)strSetter:(NSString *)str {
    if (str != nil) {
        url = str;
    }
}

+(NSString *) urlGetter{
    return url;
}

+(UIColor *)blueColorGetter{
    UIColor* blueColor = [UIColor colorWithRed:197.0/255.0 green:235.0/255.0 blue:1 alpha:1];
    return blueColor;
}

+(UIColor *)themeColorGetter{
    UIColor* themeColor = [UIColor colorWithRed:41.0/255.0 green:169.0/255.0 blue:255.0/255.0 alpha:1];
    return themeColor;
}

+(UIColor *)grayColorGetter{
    UIColor* grayColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:1];
    return grayColor;
}

+(NSDictionary *)regionDictGetter {
    NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mJson" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", jsonStr);
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSDictionary* regionDict = [[NSDictionary alloc] initWithDictionary:jsonDic];
    return regionDict;
}

+(NSArray *)provinceArrayGetter{

    NSArray* provinceArray = [[NSArray alloc] initWithArray:[[GlobalVar regionDictGetter] allKeys]];
    return provinceArray;
}

+(NSArray *)classifyArrayGetter{
    NSArray* classifyArray = [[NSArray alloc] initWithObjects:@"幼儿园",@"高中",@"初中",@"大学",@"成人教育",@"培训机构", nil];
    return classifyArray;
}

@end
