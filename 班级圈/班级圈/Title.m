//
//	Title.m
//
//	Create by Jep Xia on 30/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Title.h"

NSString *const kTitleClassid = @"classid";
NSString *const kTitleComments = @"comments";
NSString *const kTitleContent = @"content";
NSString *const kTitleCreatetime = @"createtime";
NSString *const kTitleIdField = @"id";
NSString *const kTitleLikes = @"likes";
NSString *const kTitlePics = @"pics";
NSString *const kTitleUser = @"user";
NSString *const kTitleTag = @"tag";

@interface Title ()
@end
@implementation Title




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTitleClassid] isKindOfClass:[NSNull class]]){
		self.classid = [dictionary[kTitleClassid] integerValue];
	}

	if(![dictionary[kTitleComments] isKindOfClass:[NSNull class]]){
		self.comments = dictionary[kTitleComments];
	}	
	if(![dictionary[kTitleContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kTitleContent];
	}	
	if(![dictionary[kTitleCreatetime] isKindOfClass:[NSNull class]]){
		self.createtime = [dictionary[kTitleCreatetime] integerValue];
	}

	if(![dictionary[kTitleIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kTitleIdField] integerValue];
	}

	if(![dictionary[kTitleLikes] isKindOfClass:[NSNull class]]){
		self.likes = dictionary[kTitleLikes];
	}	
	if(![dictionary[kTitlePics] isKindOfClass:[NSNull class]]){
		self.pics = dictionary[kTitlePics];
	}	
	if(![dictionary[kTitleUser] isKindOfClass:[NSNull class]]){
		self.user = [[User alloc] initWithDictionary:dictionary[kTitleUser]];
	}
    if(![dictionary[kTitleTag] isKindOfClass:[NSNull class]]){
        self.tag = dictionary[kTitleTag];
    }

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kTitleClassid] = @(self.classid);
	if(self.comments != nil){
		dictionary[kTitleComments] = self.comments;
	}
	if(self.content != nil){
		dictionary[kTitleContent] = self.content;
	}
	dictionary[kTitleCreatetime] = @(self.createtime);
	dictionary[kTitleIdField] = @(self.idField);
	if(self.likes != nil){
		dictionary[kTitleLikes] = self.likes;
	}
	if(self.pics != nil){
		dictionary[kTitlePics] = self.pics;
	}
	if(self.user != nil){
		dictionary[kTitleUser] = [self.user toDictionary];
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
	[aCoder encodeObject:@(self.classid) forKey:kTitleClassid];	if(self.comments != nil){
		[aCoder encodeObject:self.comments forKey:kTitleComments];
	}
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kTitleContent];
	}
	[aCoder encodeObject:@(self.createtime) forKey:kTitleCreatetime];	[aCoder encodeObject:@(self.idField) forKey:kTitleIdField];	if(self.likes != nil){
		[aCoder encodeObject:self.likes forKey:kTitleLikes];
	}
	if(self.pics != nil){
		[aCoder encodeObject:self.pics forKey:kTitlePics];
	}
	if(self.user != nil){
		[aCoder encodeObject:self.user forKey:kTitleUser];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.classid = [[aDecoder decodeObjectForKey:kTitleClassid] integerValue];
	self.comments = [aDecoder decodeObjectForKey:kTitleComments];
	self.content = [aDecoder decodeObjectForKey:kTitleContent];
	self.createtime = [[aDecoder decodeObjectForKey:kTitleCreatetime] integerValue];
	self.idField = [[aDecoder decodeObjectForKey:kTitleIdField] integerValue];
	self.likes = [aDecoder decodeObjectForKey:kTitleLikes];
	self.pics = [aDecoder decodeObjectForKey:kTitlePics];
	self.user = [aDecoder decodeObjectForKey:kTitleUser];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Title *copy = [Title new];

	copy.classid = self.classid;
	copy.comments = [self.comments copy];
	copy.content = [self.content copy];
	copy.createtime = self.createtime;
	copy.idField = self.idField;
	copy.likes = [self.likes copy];
	copy.pics = [self.pics copy];
	copy.user = [self.user copy];

	return copy;
}
@end
