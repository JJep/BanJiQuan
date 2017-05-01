//
//	Comment.m
//
//	Create by Jep Xia on 1/5/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Comment.h"

NSString *const kCommentContent = @"content";
NSString *const kCommentCreatetime = @"createtime";
NSString *const kCommentFromuser = @"fromuser";
NSString *const kCommentIdField = @"id";
NSString *const kCommentTitleid = @"titleid";
NSString *const kCommentTouser = @"touser";

@interface Comment ()
@end
@implementation Comment




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCommentContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kCommentContent];
	}	
	if(![dictionary[kCommentCreatetime] isKindOfClass:[NSNull class]]){
		self.createtime = [dictionary[kCommentCreatetime] integerValue];
	}

	if(![dictionary[kCommentFromuser] isKindOfClass:[NSNull class]]){
		self.fromuser = [[User alloc] initWithDictionary:dictionary[kCommentFromuser]];
	}

	if(![dictionary[kCommentIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kCommentIdField] integerValue];
	}

	if(![dictionary[kCommentTitleid] isKindOfClass:[NSNull class]]){
		self.titleid = [dictionary[kCommentTitleid] integerValue];
	}

	if(![dictionary[kCommentTouser] isKindOfClass:[NSNull class]]){
		self.touser = [[User alloc] initWithDictionary:dictionary[kCommentTouser]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.content != nil){
		dictionary[kCommentContent] = self.content;
	}
	dictionary[kCommentCreatetime] = @(self.createtime);
	if(self.fromuser != nil){
		dictionary[kCommentFromuser] = [self.fromuser toDictionary];
	}
	dictionary[kCommentIdField] = @(self.idField);
	dictionary[kCommentTitleid] = @(self.titleid);
	if(self.touser != nil){
		dictionary[kCommentTouser] = [self.touser toDictionary];
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
	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kCommentContent];
	}
	[aCoder encodeObject:@(self.createtime) forKey:kCommentCreatetime];	if(self.fromuser != nil){
		[aCoder encodeObject:self.fromuser forKey:kCommentFromuser];
	}
	[aCoder encodeObject:@(self.idField) forKey:kCommentIdField];	[aCoder encodeObject:@(self.titleid) forKey:kCommentTitleid];	if(self.touser != nil){
		[aCoder encodeObject:self.touser forKey:kCommentTouser];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.content = [aDecoder decodeObjectForKey:kCommentContent];
	self.createtime = [[aDecoder decodeObjectForKey:kCommentCreatetime] integerValue];
	self.fromuser = [aDecoder decodeObjectForKey:kCommentFromuser];
	self.idField = [[aDecoder decodeObjectForKey:kCommentIdField] integerValue];
	self.titleid = [[aDecoder decodeObjectForKey:kCommentTitleid] integerValue];
	self.touser = [aDecoder decodeObjectForKey:kCommentTouser];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Comment *copy = [Comment new];

	copy.content = [self.content copy];
	copy.createtime = self.createtime;
	copy.fromuser = [self.fromuser copy];
	copy.idField = self.idField;
	copy.titleid = self.titleid;
	copy.touser = [self.touser copy];

	return copy;
}
@end
