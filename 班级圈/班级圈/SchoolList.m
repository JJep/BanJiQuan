//
//	SchoolList.m
//
//	Create by Jep Xia on 20/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "SchoolList.h"

NSString *const kSchoolListIdField = @"id";
NSString *const kSchoolListSchool = @"school";

@interface SchoolList ()
@end
@implementation SchoolList




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kSchoolListIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kSchoolListIdField] integerValue];
	}

	if(![dictionary[kSchoolListSchool] isKindOfClass:[NSNull class]]){
		self.school = dictionary[kSchoolListSchool];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kSchoolListIdField] = @(self.idField);
	if(self.school != nil){
		dictionary[kSchoolListSchool] = self.school;
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
	[aCoder encodeObject:@(self.idField) forKey:kSchoolListIdField];	if(self.school != nil){
		[aCoder encodeObject:self.school forKey:kSchoolListSchool];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [[aDecoder decodeObjectForKey:kSchoolListIdField] integerValue];
	self.school = [aDecoder decodeObjectForKey:kSchoolListSchool];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	SchoolList *copy = [SchoolList new];

	copy.idField = self.idField;
	copy.school = [self.school copy];

	return copy;
}
@end