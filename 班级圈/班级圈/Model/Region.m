//
//	Region.m
//
//	Create by Jep Xia on 19/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Region.h"

NSString *const kRegion上海市 = @"上海市";
NSString *const kRegion云南省 = @"云南省";
NSString *const kRegion内蒙古自治区 = @"内蒙古自治区";
NSString *const kRegion北京市 = @"北京市";
NSString *const kRegion吉林省 = @"吉林省";
NSString *const kRegion四川省 = @"四川省";
NSString *const kRegion天津市 = @"天津市";
NSString *const kRegion宁夏回族自治区 = @"宁夏回族自治区";
NSString *const kRegion安徽省 = @"安徽省";
NSString *const kRegion山东省 = @"山东省";
NSString *const kRegion山西省 = @"山西省";
NSString *const kRegion广东省 = @"广东省";
NSString *const kRegion广西壮族自治区 = @"广西壮族自治区";
NSString *const kRegion新疆维吾尔自治区 = @"新疆维吾尔自治区";
NSString *const kRegion江苏省 = @"江苏省";
NSString *const kRegion江西省 = @"江西省";
NSString *const kRegion河北省 = @"河北省";
NSString *const kRegion河南省 = @"河南省";
NSString *const kRegion浙江省 = @"浙江省";
NSString *const kRegion海南 = @"海南";
NSString *const kRegion海南省 = @"海南省";
NSString *const kRegion湖北省 = @"湖北省";
NSString *const kRegion湖南省 = @"湖南省";
NSString *const kRegion澳门特别行政区 = @"澳门特别行政区";
NSString *const kRegion甘肃省 = @"甘肃省";
NSString *const kRegion福建省 = @"福建省";
NSString *const kRegion西藏自治区 = @"西藏自治区";
NSString *const kRegion贵州省 = @"贵州省";
NSString *const kRegion辽宁省 = @"辽宁省";
NSString *const kRegion重庆市 = @"重庆市";
NSString *const kRegion陕西省 = @"陕西省";
NSString *const kRegion青海省 = @"青海省";
NSString *const kRegion香港 = @"香港";
NSString *const kRegion黑龙江省 = @"黑龙江省";

@interface Region ()
@end
@implementation Region




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kRegion上海市] isKindOfClass:[NSNull class]]){
		self.上海市 = dictionary[kRegion上海市];
	}	
	if(![dictionary[kRegion云南省] isKindOfClass:[NSNull class]]){
		self.云南省 = dictionary[kRegion云南省];
	}	
	if(![dictionary[kRegion内蒙古自治区] isKindOfClass:[NSNull class]]){
		self.内蒙古自治区 = dictionary[kRegion内蒙古自治区];
	}	
	if(![dictionary[kRegion北京市] isKindOfClass:[NSNull class]]){
		self.北京市 = dictionary[kRegion北京市];
	}	
	if(![dictionary[kRegion吉林省] isKindOfClass:[NSNull class]]){
		self.吉林省 = dictionary[kRegion吉林省];
	}	
	if(![dictionary[kRegion四川省] isKindOfClass:[NSNull class]]){
		self.四川省 = dictionary[kRegion四川省];
	}	
	if(![dictionary[kRegion天津市] isKindOfClass:[NSNull class]]){
		self.天津市 = dictionary[kRegion天津市];
	}	
	if(![dictionary[kRegion宁夏回族自治区] isKindOfClass:[NSNull class]]){
		self.宁夏回族自治区 = dictionary[kRegion宁夏回族自治区];
	}	
	if(![dictionary[kRegion安徽省] isKindOfClass:[NSNull class]]){
		self.安徽省 = dictionary[kRegion安徽省];
	}	
	if(![dictionary[kRegion山东省] isKindOfClass:[NSNull class]]){
		self.山东省 = dictionary[kRegion山东省];
	}	
	if(![dictionary[kRegion山西省] isKindOfClass:[NSNull class]]){
		self.山西省 = dictionary[kRegion山西省];
	}	
	if(![dictionary[kRegion广东省] isKindOfClass:[NSNull class]]){
		self.广东省 = dictionary[kRegion广东省];
	}	
	if(![dictionary[kRegion广西壮族自治区] isKindOfClass:[NSNull class]]){
		self.广西壮族自治区 = dictionary[kRegion广西壮族自治区];
	}	
	if(![dictionary[kRegion新疆维吾尔自治区] isKindOfClass:[NSNull class]]){
		self.新疆维吾尔自治区 = dictionary[kRegion新疆维吾尔自治区];
	}	
	if(![dictionary[kRegion江苏省] isKindOfClass:[NSNull class]]){
		self.江苏省 = dictionary[kRegion江苏省];
	}	
	if(![dictionary[kRegion江西省] isKindOfClass:[NSNull class]]){
		self.江西省 = dictionary[kRegion江西省];
	}	
	if(![dictionary[kRegion河北省] isKindOfClass:[NSNull class]]){
		self.河北省 = dictionary[kRegion河北省];
	}	
	if(![dictionary[kRegion河南省] isKindOfClass:[NSNull class]]){
		self.河南省 = dictionary[kRegion河南省];
	}	
	if(![dictionary[kRegion浙江省] isKindOfClass:[NSNull class]]){
		self.浙江省 = dictionary[kRegion浙江省];
	}	
	if(![dictionary[kRegion海南] isKindOfClass:[NSNull class]]){
		self.海南 = dictionary[kRegion海南];
	}	
	if(![dictionary[kRegion海南省] isKindOfClass:[NSNull class]]){
		self.海南省 = dictionary[kRegion海南省];
	}	
	if(![dictionary[kRegion湖北省] isKindOfClass:[NSNull class]]){
		self.湖北省 = dictionary[kRegion湖北省];
	}	
	if(![dictionary[kRegion湖南省] isKindOfClass:[NSNull class]]){
		self.湖南省 = dictionary[kRegion湖南省];
	}	
	if(![dictionary[kRegion澳门特别行政区] isKindOfClass:[NSNull class]]){
		self.澳门特别行政区 = dictionary[kRegion澳门特别行政区];
	}	
	if(![dictionary[kRegion甘肃省] isKindOfClass:[NSNull class]]){
		self.甘肃省 = dictionary[kRegion甘肃省];
	}	
	if(![dictionary[kRegion福建省] isKindOfClass:[NSNull class]]){
		self.福建省 = dictionary[kRegion福建省];
	}	
	if(![dictionary[kRegion西藏自治区] isKindOfClass:[NSNull class]]){
		self.西藏自治区 = dictionary[kRegion西藏自治区];
	}	
	if(![dictionary[kRegion贵州省] isKindOfClass:[NSNull class]]){
		self.贵州省 = dictionary[kRegion贵州省];
	}	
	if(![dictionary[kRegion辽宁省] isKindOfClass:[NSNull class]]){
		self.辽宁省 = dictionary[kRegion辽宁省];
	}	
	if(![dictionary[kRegion重庆市] isKindOfClass:[NSNull class]]){
		self.重庆市 = dictionary[kRegion重庆市];
	}	
	if(![dictionary[kRegion陕西省] isKindOfClass:[NSNull class]]){
		self.陕西省 = dictionary[kRegion陕西省];
	}	
	if(![dictionary[kRegion青海省] isKindOfClass:[NSNull class]]){
		self.青海省 = dictionary[kRegion青海省];
	}	
	if(![dictionary[kRegion香港] isKindOfClass:[NSNull class]]){
		self.香港 = dictionary[kRegion香港];
	}	
	if(![dictionary[kRegion黑龙江省] isKindOfClass:[NSNull class]]){
		self.黑龙江省 = dictionary[kRegion黑龙江省];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.上海市 != nil){
		dictionary[kRegion上海市] = self.上海市;
	}
	if(self.云南省 != nil){
		dictionary[kRegion云南省] = self.云南省;
	}
	if(self.内蒙古自治区 != nil){
		dictionary[kRegion内蒙古自治区] = self.内蒙古自治区;
	}
	if(self.北京市 != nil){
		dictionary[kRegion北京市] = self.北京市;
	}
	if(self.吉林省 != nil){
		dictionary[kRegion吉林省] = self.吉林省;
	}
	if(self.四川省 != nil){
		dictionary[kRegion四川省] = self.四川省;
	}
	if(self.天津市 != nil){
		dictionary[kRegion天津市] = self.天津市;
	}
	if(self.宁夏回族自治区 != nil){
		dictionary[kRegion宁夏回族自治区] = self.宁夏回族自治区;
	}
	if(self.安徽省 != nil){
		dictionary[kRegion安徽省] = self.安徽省;
	}
	if(self.山东省 != nil){
		dictionary[kRegion山东省] = self.山东省;
	}
	if(self.山西省 != nil){
		dictionary[kRegion山西省] = self.山西省;
	}
	if(self.广东省 != nil){
		dictionary[kRegion广东省] = self.广东省;
	}
	if(self.广西壮族自治区 != nil){
		dictionary[kRegion广西壮族自治区] = self.广西壮族自治区;
	}
	if(self.新疆维吾尔自治区 != nil){
		dictionary[kRegion新疆维吾尔自治区] = self.新疆维吾尔自治区;
	}
	if(self.江苏省 != nil){
		dictionary[kRegion江苏省] = self.江苏省;
	}
	if(self.江西省 != nil){
		dictionary[kRegion江西省] = self.江西省;
	}
	if(self.河北省 != nil){
		dictionary[kRegion河北省] = self.河北省;
	}
	if(self.河南省 != nil){
		dictionary[kRegion河南省] = self.河南省;
	}
	if(self.浙江省 != nil){
		dictionary[kRegion浙江省] = self.浙江省;
	}
	if(self.海南 != nil){
		dictionary[kRegion海南] = self.海南;
	}
	if(self.海南省 != nil){
		dictionary[kRegion海南省] = self.海南省;
	}
	if(self.湖北省 != nil){
		dictionary[kRegion湖北省] = self.湖北省;
	}
	if(self.湖南省 != nil){
		dictionary[kRegion湖南省] = self.湖南省;
	}
	if(self.澳门特别行政区 != nil){
		dictionary[kRegion澳门特别行政区] = self.澳门特别行政区;
	}
	if(self.甘肃省 != nil){
		dictionary[kRegion甘肃省] = self.甘肃省;
	}
	if(self.福建省 != nil){
		dictionary[kRegion福建省] = self.福建省;
	}
	if(self.西藏自治区 != nil){
		dictionary[kRegion西藏自治区] = self.西藏自治区;
	}
	if(self.贵州省 != nil){
		dictionary[kRegion贵州省] = self.贵州省;
	}
	if(self.辽宁省 != nil){
		dictionary[kRegion辽宁省] = self.辽宁省;
	}
	if(self.重庆市 != nil){
		dictionary[kRegion重庆市] = self.重庆市;
	}
	if(self.陕西省 != nil){
		dictionary[kRegion陕西省] = self.陕西省;
	}
	if(self.青海省 != nil){
		dictionary[kRegion青海省] = self.青海省;
	}
	if(self.香港 != nil){
		dictionary[kRegion香港] = self.香港;
	}
	if(self.黑龙江省 != nil){
		dictionary[kRegion黑龙江省] = self.黑龙江省;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.上海市 != nil){
		[aCoder encodeObject:self.上海市 forKey:kRegion上海市];
	}
	if(self.云南省 != nil){
		[aCoder encodeObject:self.云南省 forKey:kRegion云南省];
	}
	if(self.内蒙古自治区 != nil){
		[aCoder encodeObject:self.内蒙古自治区 forKey:kRegion内蒙古自治区];
	}
	if(self.北京市 != nil){
		[aCoder encodeObject:self.北京市 forKey:kRegion北京市];
	}
	if(self.吉林省 != nil){
		[aCoder encodeObject:self.吉林省 forKey:kRegion吉林省];
	}
	if(self.四川省 != nil){
		[aCoder encodeObject:self.四川省 forKey:kRegion四川省];
	}
	if(self.天津市 != nil){
		[aCoder encodeObject:self.天津市 forKey:kRegion天津市];
	}
	if(self.宁夏回族自治区 != nil){
		[aCoder encodeObject:self.宁夏回族自治区 forKey:kRegion宁夏回族自治区];
	}
	if(self.安徽省 != nil){
		[aCoder encodeObject:self.安徽省 forKey:kRegion安徽省];
	}
	if(self.山东省 != nil){
		[aCoder encodeObject:self.山东省 forKey:kRegion山东省];
	}
	if(self.山西省 != nil){
		[aCoder encodeObject:self.山西省 forKey:kRegion山西省];
	}
	if(self.广东省 != nil){
		[aCoder encodeObject:self.广东省 forKey:kRegion广东省];
	}
	if(self.广西壮族自治区 != nil){
		[aCoder encodeObject:self.广西壮族自治区 forKey:kRegion广西壮族自治区];
	}
	if(self.新疆维吾尔自治区 != nil){
		[aCoder encodeObject:self.新疆维吾尔自治区 forKey:kRegion新疆维吾尔自治区];
	}
	if(self.江苏省 != nil){
		[aCoder encodeObject:self.江苏省 forKey:kRegion江苏省];
	}
	if(self.江西省 != nil){
		[aCoder encodeObject:self.江西省 forKey:kRegion江西省];
	}
	if(self.河北省 != nil){
		[aCoder encodeObject:self.河北省 forKey:kRegion河北省];
	}
	if(self.河南省 != nil){
		[aCoder encodeObject:self.河南省 forKey:kRegion河南省];
	}
	if(self.浙江省 != nil){
		[aCoder encodeObject:self.浙江省 forKey:kRegion浙江省];
	}
	if(self.海南 != nil){
		[aCoder encodeObject:self.海南 forKey:kRegion海南];
	}
	if(self.海南省 != nil){
		[aCoder encodeObject:self.海南省 forKey:kRegion海南省];
	}
	if(self.湖北省 != nil){
		[aCoder encodeObject:self.湖北省 forKey:kRegion湖北省];
	}
	if(self.湖南省 != nil){
		[aCoder encodeObject:self.湖南省 forKey:kRegion湖南省];
	}
	if(self.澳门特别行政区 != nil){
		[aCoder encodeObject:self.澳门特别行政区 forKey:kRegion澳门特别行政区];
	}
	if(self.甘肃省 != nil){
		[aCoder encodeObject:self.甘肃省 forKey:kRegion甘肃省];
	}
	if(self.福建省 != nil){
		[aCoder encodeObject:self.福建省 forKey:kRegion福建省];
	}
	if(self.西藏自治区 != nil){
		[aCoder encodeObject:self.西藏自治区 forKey:kRegion西藏自治区];
	}
	if(self.贵州省 != nil){
		[aCoder encodeObject:self.贵州省 forKey:kRegion贵州省];
	}
	if(self.辽宁省 != nil){
		[aCoder encodeObject:self.辽宁省 forKey:kRegion辽宁省];
	}
	if(self.重庆市 != nil){
		[aCoder encodeObject:self.重庆市 forKey:kRegion重庆市];
	}
	if(self.陕西省 != nil){
		[aCoder encodeObject:self.陕西省 forKey:kRegion陕西省];
	}
	if(self.青海省 != nil){
		[aCoder encodeObject:self.青海省 forKey:kRegion青海省];
	}
	if(self.香港 != nil){
		[aCoder encodeObject:self.香港 forKey:kRegion香港];
	}
	if(self.黑龙江省 != nil){
		[aCoder encodeObject:self.黑龙江省 forKey:kRegion黑龙江省];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.上海市 = [aDecoder decodeObjectForKey:kRegion上海市];
	self.云南省 = [aDecoder decodeObjectForKey:kRegion云南省];
	self.内蒙古自治区 = [aDecoder decodeObjectForKey:kRegion内蒙古自治区];
	self.北京市 = [aDecoder decodeObjectForKey:kRegion北京市];
	self.吉林省 = [aDecoder decodeObjectForKey:kRegion吉林省];
	self.四川省 = [aDecoder decodeObjectForKey:kRegion四川省];
	self.天津市 = [aDecoder decodeObjectForKey:kRegion天津市];
	self.宁夏回族自治区 = [aDecoder decodeObjectForKey:kRegion宁夏回族自治区];
	self.安徽省 = [aDecoder decodeObjectForKey:kRegion安徽省];
	self.山东省 = [aDecoder decodeObjectForKey:kRegion山东省];
	self.山西省 = [aDecoder decodeObjectForKey:kRegion山西省];
	self.广东省 = [aDecoder decodeObjectForKey:kRegion广东省];
	self.广西壮族自治区 = [aDecoder decodeObjectForKey:kRegion广西壮族自治区];
	self.新疆维吾尔自治区 = [aDecoder decodeObjectForKey:kRegion新疆维吾尔自治区];
	self.江苏省 = [aDecoder decodeObjectForKey:kRegion江苏省];
	self.江西省 = [aDecoder decodeObjectForKey:kRegion江西省];
	self.河北省 = [aDecoder decodeObjectForKey:kRegion河北省];
	self.河南省 = [aDecoder decodeObjectForKey:kRegion河南省];
	self.浙江省 = [aDecoder decodeObjectForKey:kRegion浙江省];
	self.海南 = [aDecoder decodeObjectForKey:kRegion海南];
	self.海南省 = [aDecoder decodeObjectForKey:kRegion海南省];
	self.湖北省 = [aDecoder decodeObjectForKey:kRegion湖北省];
	self.湖南省 = [aDecoder decodeObjectForKey:kRegion湖南省];
	self.澳门特别行政区 = [aDecoder decodeObjectForKey:kRegion澳门特别行政区];
	self.甘肃省 = [aDecoder decodeObjectForKey:kRegion甘肃省];
	self.福建省 = [aDecoder decodeObjectForKey:kRegion福建省];
	self.西藏自治区 = [aDecoder decodeObjectForKey:kRegion西藏自治区];
	self.贵州省 = [aDecoder decodeObjectForKey:kRegion贵州省];
	self.辽宁省 = [aDecoder decodeObjectForKey:kRegion辽宁省];
	self.重庆市 = [aDecoder decodeObjectForKey:kRegion重庆市];
	self.陕西省 = [aDecoder decodeObjectForKey:kRegion陕西省];
	self.青海省 = [aDecoder decodeObjectForKey:kRegion青海省];
	self.香港 = [aDecoder decodeObjectForKey:kRegion香港];
	self.黑龙江省 = [aDecoder decodeObjectForKey:kRegion黑龙江省];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Region *copy = [Region new];

	copy.上海市 = [self.上海市 copy];
	copy.云南省 = [self.云南省 copy];
	copy.内蒙古自治区 = [self.内蒙古自治区 copy];
	copy.北京市 = [self.北京市 copy];
	copy.吉林省 = [self.吉林省 copy];
	copy.四川省 = [self.四川省 copy];
	copy.天津市 = [self.天津市 copy];
	copy.宁夏回族自治区 = [self.宁夏回族自治区 copy];
	copy.安徽省 = [self.安徽省 copy];
	copy.山东省 = [self.山东省 copy];
	copy.山西省 = [self.山西省 copy];
	copy.广东省 = [self.广东省 copy];
	copy.广西壮族自治区 = [self.广西壮族自治区 copy];
	copy.新疆维吾尔自治区 = [self.新疆维吾尔自治区 copy];
	copy.江苏省 = [self.江苏省 copy];
	copy.江西省 = [self.江西省 copy];
	copy.河北省 = [self.河北省 copy];
	copy.河南省 = [self.河南省 copy];
	copy.浙江省 = [self.浙江省 copy];
	copy.海南 = [self.海南 copy];
	copy.海南省 = [self.海南省 copy];
	copy.湖北省 = [self.湖北省 copy];
	copy.湖南省 = [self.湖南省 copy];
	copy.澳门特别行政区 = [self.澳门特别行政区 copy];
	copy.甘肃省 = [self.甘肃省 copy];
	copy.福建省 = [self.福建省 copy];
	copy.西藏自治区 = [self.西藏自治区 copy];
	copy.贵州省 = [self.贵州省 copy];
	copy.辽宁省 = [self.辽宁省 copy];
	copy.重庆市 = [self.重庆市 copy];
	copy.陕西省 = [self.陕西省 copy];
	copy.青海省 = [self.青海省 copy];
	copy.香港 = [self.香港 copy];
	copy.黑龙江省 = [self.黑龙江省 copy];

	return copy;
}
@end