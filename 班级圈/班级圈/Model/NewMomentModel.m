//
//	NewMomentModel.m
//
//	Create by Jep Xia on 23/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "NewMomentModel.h"

NSString *const kNewMomentModelClasses = @"classes";
NSString *const kNewMomentModelStatus = @"status";

@interface NewMomentModel ()
@end
@implementation NewMomentModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kNewMomentModelClasses] != nil && [dictionary[kNewMomentModelClasses] isKindOfClass:[NSArray class]]){
		NSArray * classesDictionaries = dictionary[kNewMomentModelClasses];
		NSMutableArray * classesItems = [NSMutableArray array];
		for(NSDictionary * classesDictionary in classesDictionaries){
			Classe * classesItem = [[Classe alloc] initWithDictionary:classesDictionary];
			[classesItems addObject:classesItem];
		}
		self.classes = classesItems;
	}
	if(![dictionary[kNewMomentModelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kNewMomentModelStatus] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.classes != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Classe * classesElement in self.classes){
			[dictionaryElements addObject:[classesElement toDictionary]];
		}
		dictionary[kNewMomentModelClasses] = dictionaryElements;
	}
	dictionary[kNewMomentModelStatus] = @(self.status);
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
	if(self.classes != nil){
		[aCoder encodeObject:self.classes forKey:kNewMomentModelClasses];
	}
	[aCoder encodeObject:@(self.status) forKey:kNewMomentModelStatus];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.classes = [aDecoder decodeObjectForKey:kNewMomentModelClasses];
	self.status = [[aDecoder decodeObjectForKey:kNewMomentModelStatus] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	NewMomentModel *copy = [NewMomentModel new];

	copy.classes = [self.classes copy];
	copy.status = self.status;

	return copy;
}
@end