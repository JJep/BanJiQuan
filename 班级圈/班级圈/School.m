//
//	School.m
//
//	Create by Jep Xia on 27/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "School.h"

NSString *const kSchoolArea = @"area";
NSString *const kSchoolCity = @"city";
NSString *const kSchoolCjsort = @"cjsort";
NSString *const kSchoolClassify = @"classify";
NSString *const kSchoolDescriptionField = @"description";
NSString *const kSchoolIdField = @"id";
NSString *const kSchoolProvince = @"province";
NSString *const kSchoolSchool = @"school";

@interface School ()
@end
@implementation School




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSchoolArea] isKindOfClass:[NSNull class]]){
		self.area = dictionary[kSchoolArea];
	}	
	if(![dictionary[kSchoolCity] isKindOfClass:[NSNull class]]){
		self.city = dictionary[kSchoolCity];
	}	
	if(![dictionary[kSchoolCjsort] isKindOfClass:[NSNull class]]){
		self.cjsort = dictionary[kSchoolCjsort];
	}	
	if(![dictionary[kSchoolClassify] isKindOfClass:[NSNull class]]){
		self.classify = [dictionary[kSchoolClassify] integerValue];
	}

	if(![dictionary[kSchoolDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[kSchoolDescriptionField];
	}	
	if(![dictionary[kSchoolIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kSchoolIdField] integerValue];
	}

	if(![dictionary[kSchoolProvince] isKindOfClass:[NSNull class]]){
		self.province = dictionary[kSchoolProvince];
	}	
	if(![dictionary[kSchoolSchool] isKindOfClass:[NSNull class]]){
		self.school = dictionary[kSchoolSchool];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.area != nil){
		dictionary[kSchoolArea] = self.area;
	}
	if(self.city != nil){
		dictionary[kSchoolCity] = self.city;
	}
	if(self.cjsort != nil){
		dictionary[kSchoolCjsort] = self.cjsort;
	}
	dictionary[kSchoolClassify] = @(self.classify);
	if(self.descriptionField != nil){
		dictionary[kSchoolDescriptionField] = self.descriptionField;
	}
	dictionary[kSchoolIdField] = @(self.idField);
	if(self.province != nil){
		dictionary[kSchoolProvince] = self.province;
	}
	if(self.school != nil){
		dictionary[kSchoolSchool] = self.school;
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
	if(self.area != nil){
		[aCoder encodeObject:self.area forKey:kSchoolArea];
	}
	if(self.city != nil){
		[aCoder encodeObject:self.city forKey:kSchoolCity];
	}
	if(self.cjsort != nil){
		[aCoder encodeObject:self.cjsort forKey:kSchoolCjsort];
	}
	[aCoder encodeObject:@(self.classify) forKey:kSchoolClassify];	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kSchoolDescriptionField];
	}
	[aCoder encodeObject:@(self.idField) forKey:kSchoolIdField];	if(self.province != nil){
		[aCoder encodeObject:self.province forKey:kSchoolProvince];
	}
	if(self.school != nil){
		[aCoder encodeObject:self.school forKey:kSchoolSchool];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.area = [aDecoder decodeObjectForKey:kSchoolArea];
	self.city = [aDecoder decodeObjectForKey:kSchoolCity];
	self.cjsort = [aDecoder decodeObjectForKey:kSchoolCjsort];
	self.classify = [[aDecoder decodeObjectForKey:kSchoolClassify] integerValue];
	self.descriptionField = [aDecoder decodeObjectForKey:kSchoolDescriptionField];
	self.idField = [[aDecoder decodeObjectForKey:kSchoolIdField] integerValue];
	self.province = [aDecoder decodeObjectForKey:kSchoolProvince];
	self.school = [aDecoder decodeObjectForKey:kSchoolSchool];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	School *copy = [School new];

	copy.area = [self.area copy];
	copy.city = [self.city copy];
	copy.cjsort = [self.cjsort copy];
	copy.classify = self.classify;
	copy.descriptionField = [self.descriptionField copy];
	copy.idField = self.idField;
	copy.province = [self.province copy];
	copy.school = [self.school copy];

	return copy;
}
@end