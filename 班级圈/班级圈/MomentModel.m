//
//	MomentModel.m
//
//	Create by Jep Xia on 30/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MomentModel.h"

NSString *const kMomentModelClasses = @"classes";
NSString *const kMomentModelStatus = @"status";
NSString *const kMomentModelTitles = @"titles";

@interface MomentModel ()
@end
@implementation MomentModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kMomentModelClasses] != nil && [dictionary[kMomentModelClasses] isKindOfClass:[NSArray class]]){
		NSArray * classesDictionaries = dictionary[kMomentModelClasses];
		NSMutableArray * classesItems = [NSMutableArray array];
		for(NSDictionary * classesDictionary in classesDictionaries){
			Classe * classesItem = [[Classe alloc] initWithDictionary:classesDictionary];
			[classesItems addObject:classesItem];
		}
		self.classes = classesItems;
	}
	if(![dictionary[kMomentModelStatus] isKindOfClass:[NSNull class]]){
		self.status = [dictionary[kMomentModelStatus] integerValue];
	}

	if(dictionary[kMomentModelTitles] != nil && [dictionary[kMomentModelTitles] isKindOfClass:[NSArray class]]){
		NSArray * titlesDictionaries = dictionary[kMomentModelTitles];
		NSMutableArray * titlesItems = [NSMutableArray array];
		for(NSDictionary * titlesDictionary in titlesDictionaries){
			Title * titlesItem = [[Title alloc] initWithDictionary:titlesDictionary];
			[titlesItems addObject:titlesItem];
		}
		self.titles = titlesItems;
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
		dictionary[kMomentModelClasses] = dictionaryElements;
	}
	dictionary[kMomentModelStatus] = @(self.status);
	if(self.titles != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Title * titlesElement in self.titles){
			[dictionaryElements addObject:[titlesElement toDictionary]];
		}
		dictionary[kMomentModelTitles] = dictionaryElements;
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
	if(self.classes != nil){
		[aCoder encodeObject:self.classes forKey:kMomentModelClasses];
	}
	[aCoder encodeObject:@(self.status) forKey:kMomentModelStatus];	if(self.titles != nil){
		[aCoder encodeObject:self.titles forKey:kMomentModelTitles];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.classes = [aDecoder decodeObjectForKey:kMomentModelClasses];
	self.status = [[aDecoder decodeObjectForKey:kMomentModelStatus] integerValue];
	self.titles = [aDecoder decodeObjectForKey:kMomentModelTitles];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MomentModel *copy = [MomentModel new];

	copy.classes = [self.classes copy];
	copy.status = self.status;
	copy.titles = [self.titles copy];

	return copy;
}
@end