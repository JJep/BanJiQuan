//
//	Title.m
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Title.h"

NSString *const kTitleAvThumbnails = @"avThumbnails";
NSString *const kTitleClassid = @"classid";
NSString *const kTitleContent = @"content";
NSString *const kTitleCreatetime = @"createtime";
NSString *const kTitleDeleted = @"deleted";
NSString *const kTitleIdField = @"id";
NSString *const kTitlePicThumbnails = @"picThumbnails";
NSString *const kTitlePics = @"pics";
NSString *const kTitleUser = @"user";
NSString *const kTitleUserid = @"userid";
NSString *const kTitleVideos = @"videos";

@interface Title ()
@end
@implementation Title




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kTitleAvThumbnails] isKindOfClass:[NSNull class]]){
		self.avThumbnails = dictionary[kTitleAvThumbnails];
	}	
	if(![dictionary[kTitleClassid] isKindOfClass:[NSNull class]]){
		self.classid = [dictionary[kTitleClassid] integerValue];
	}

	if(![dictionary[kTitleContent] isKindOfClass:[NSNull class]]){
		self.content = dictionary[kTitleContent];
	}	
	if(![dictionary[kTitleCreatetime] isKindOfClass:[NSNull class]]){
		self.createtime = [dictionary[kTitleCreatetime] integerValue];
	}

	if(![dictionary[kTitleDeleted] isKindOfClass:[NSNull class]]){
		self.deleted = dictionary[kTitleDeleted];
	}	
	if(![dictionary[kTitleIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kTitleIdField] integerValue];
	}

	if(![dictionary[kTitlePicThumbnails] isKindOfClass:[NSNull class]]){
		self.picThumbnails = dictionary[kTitlePicThumbnails];
	}	
	if(![dictionary[kTitlePics] isKindOfClass:[NSNull class]]){
		self.pics = dictionary[kTitlePics];
	}	
	if(![dictionary[kTitleUser] isKindOfClass:[NSNull class]]){
		self.user = [[User alloc] initWithDictionary:dictionary[kTitleUser]];
	}

	if(![dictionary[kTitleUserid] isKindOfClass:[NSNull class]]){
		self.userid = dictionary[kTitleUserid];
	}	
	if(![dictionary[kTitleVideos] isKindOfClass:[NSNull class]]){
		self.videos = dictionary[kTitleVideos];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.avThumbnails != nil){
		dictionary[kTitleAvThumbnails] = self.avThumbnails;
	}
	dictionary[kTitleClassid] = @(self.classid);
	if(self.content != nil){
		dictionary[kTitleContent] = self.content;
	}
	dictionary[kTitleCreatetime] = @(self.createtime);
	if(self.deleted != nil){
		dictionary[kTitleDeleted] = self.deleted;
	}
	dictionary[kTitleIdField] = @(self.idField);
	if(self.picThumbnails != nil){
		dictionary[kTitlePicThumbnails] = self.picThumbnails;
	}
	if(self.pics != nil){
		dictionary[kTitlePics] = self.pics;
	}
	if(self.user != nil){
		dictionary[kTitleUser] = [self.user toDictionary];
	}
	if(self.userid != nil){
		dictionary[kTitleUserid] = self.userid;
	}
	if(self.videos != nil){
		dictionary[kTitleVideos] = self.videos;
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
	if(self.avThumbnails != nil){
		[aCoder encodeObject:self.avThumbnails forKey:kTitleAvThumbnails];
	}
	[aCoder encodeObject:@(self.classid) forKey:kTitleClassid];	if(self.content != nil){
		[aCoder encodeObject:self.content forKey:kTitleContent];
	}
	[aCoder encodeObject:@(self.createtime) forKey:kTitleCreatetime];	if(self.deleted != nil){
		[aCoder encodeObject:self.deleted forKey:kTitleDeleted];
	}
	[aCoder encodeObject:@(self.idField) forKey:kTitleIdField];	if(self.picThumbnails != nil){
		[aCoder encodeObject:self.picThumbnails forKey:kTitlePicThumbnails];
	}
	if(self.pics != nil){
		[aCoder encodeObject:self.pics forKey:kTitlePics];
	}
	if(self.user != nil){
		[aCoder encodeObject:self.user forKey:kTitleUser];
	}
	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:kTitleUserid];
	}
	if(self.videos != nil){
		[aCoder encodeObject:self.videos forKey:kTitleVideos];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.avThumbnails = [aDecoder decodeObjectForKey:kTitleAvThumbnails];
	self.classid = [[aDecoder decodeObjectForKey:kTitleClassid] integerValue];
	self.content = [aDecoder decodeObjectForKey:kTitleContent];
	self.createtime = [[aDecoder decodeObjectForKey:kTitleCreatetime] integerValue];
	self.deleted = [aDecoder decodeObjectForKey:kTitleDeleted];
	self.idField = [[aDecoder decodeObjectForKey:kTitleIdField] integerValue];
	self.picThumbnails = [aDecoder decodeObjectForKey:kTitlePicThumbnails];
	self.pics = [aDecoder decodeObjectForKey:kTitlePics];
	self.user = [aDecoder decodeObjectForKey:kTitleUser];
	self.userid = [aDecoder decodeObjectForKey:kTitleUserid];
	self.videos = [aDecoder decodeObjectForKey:kTitleVideos];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Title *copy = [Title new];

	copy.avThumbnails = [self.avThumbnails copy];
	copy.classid = self.classid;
	copy.content = [self.content copy];
	copy.createtime = self.createtime;
	copy.deleted = [self.deleted copy];
	copy.idField = self.idField;
	copy.picThumbnails = [self.picThumbnails copy];
	copy.pics = [self.pics copy];
	copy.user = [self.user copy];
	copy.userid = [self.userid copy];
	copy.videos = [self.videos copy];

	return copy;
}
@end