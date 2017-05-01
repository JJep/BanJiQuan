//
//	MyProfileModel.m
//
//	Create by Jep Xia on 18/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MyProfileModel.h"

NSString *const kMyProfileModelStatus = @"status";
NSString *const kMyProfileModelUser = @"user";

@interface MyProfileModel ()
@end
@implementation MyProfileModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kMyProfileModelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kMyProfileModelStatus] integerValue];
	}

	if(![dictionary[kMyProfileModelUser] isKindOfClass:[NSNull class]]){
		self.user = [[User alloc] initWithDictionary:dictionary[kMyProfileModelUser]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMyProfileModelStatus] = @(self.status);
	if(self.user != nil){
		dictionary[kMyProfileModelUser] = [self.user toDictionary];
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
	[aCoder encodeObject:@(self.status) forKey:kMyProfileModelStatus];	if(self.user != nil){
		[aCoder encodeObject:self.user forKey:kMyProfileModelUser];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.status = [[aDecoder decodeObjectForKey:kMyProfileModelStatus] integerValue];
	self.user = [aDecoder decodeObjectForKey:kMyProfileModelUser];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MyProfileModel *copy = [MyProfileModel new];

	copy.status = self.status;
	copy.user = [self.user copy];

	return copy;
}
@end