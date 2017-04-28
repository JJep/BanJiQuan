//
//	schoolmodel.m
//
//	Create by Jep Xia on 27/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "schoolmodel.h"

NSString *const kschoolmodelFlag = @"flag";
NSString *const kschoolmodelSchool = @"school";
NSString *const kschoolmodelStatus = @"status";

@interface schoolmodel ()
@end
@implementation schoolmodel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kschoolmodelFlag] isKindOfClass:[NSNull class]]){
		self.flag = [dictionary[kschoolmodelFlag] integerValue];
	}

	if(![dictionary[kschoolmodelSchool] isKindOfClass:[NSNull class]]){
		self.school = [[School alloc] initWithDictionary:dictionary[kschoolmodelSchool]];
	}

	if(![dictionary[kschoolmodelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kschoolmodelStatus] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kschoolmodelFlag] = @(self.flag);
	if(self.school != nil){
		dictionary[kschoolmodelSchool] = [self.school toDictionary];
	}
	dictionary[kschoolmodelStatus] = @(self.status);
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
	[aCoder encodeObject:@(self.flag) forKey:kschoolmodelFlag];	if(self.school != nil){
		[aCoder encodeObject:self.school forKey:kschoolmodelSchool];
	}
	[aCoder encodeObject:@(self.status) forKey:kschoolmodelStatus];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.flag = [[aDecoder decodeObjectForKey:kschoolmodelFlag] integerValue];
	self.school = [aDecoder decodeObjectForKey:kschoolmodelSchool];
	self.status = [[aDecoder decodeObjectForKey:kschoolmodelStatus] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	schoolmodel *copy = [schoolmodel new];

	copy.flag = self.flag;
	copy.school = [self.school copy];
	copy.status = self.status;

	return copy;
}
@end