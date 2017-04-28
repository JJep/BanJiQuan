//
//	Classe.m
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Classe.h"

NSString *const kClasseAnnouncement = @"announcement";
NSString *const kClasseCreatetime = @"createtime";
NSString *const kClasseHead = @"head";
NSString *const kClasseIdField = @"id";
NSString *const kClasseInvitation = @"invitation";
NSString *const kClasseName = @"name";
NSString *const kClasseQrcode = @"qrcode";
NSString *const kClasseRoot = @"root";
NSString *const kClasseSchoolid = @"schoolid";
NSString *const kClasseTag = @"tag";

@interface Classe ()
@end
@implementation Classe




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kClasseAnnouncement] isKindOfClass:[NSNull class]]){
		self.announcement = dictionary[kClasseAnnouncement];
	}	
	if(![dictionary[kClasseCreatetime] isKindOfClass:[NSNull class]]){
		self.createtime = dictionary[kClasseCreatetime];
	}	
	if(![dictionary[kClasseHead] isKindOfClass:[NSNull class]]){
		self.head = dictionary[kClasseHead];
	}	
	if(![dictionary[kClasseIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kClasseIdField] integerValue];
	}

	if(![dictionary[kClasseInvitation] isKindOfClass:[NSNull class]]){
		self.invitation = dictionary[kClasseInvitation];
	}	
	if(![dictionary[kClasseName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kClasseName];
	}	
	if(![dictionary[kClasseQrcode] isKindOfClass:[NSNull class]]){
		self.qrcode = dictionary[kClasseQrcode];
	}	
	if(![dictionary[kClasseRoot] isKindOfClass:[NSNull class]]){
		self.root = dictionary[kClasseRoot];
	}	
	if(![dictionary[kClasseSchoolid] isKindOfClass:[NSNull class]]){
		self.schoolid = dictionary[kClasseSchoolid];
	}	
	if(![dictionary[kClasseTag] isKindOfClass:[NSNull class]]){
		self.tag = dictionary[kClasseTag];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.announcement != nil){
		dictionary[kClasseAnnouncement] = self.announcement;
	}
	if(self.createtime != nil){
		dictionary[kClasseCreatetime] = self.createtime;
	}
	if(self.head != nil){
		dictionary[kClasseHead] = self.head;
	}
	dictionary[kClasseIdField] = @(self.idField);
	if(self.invitation != nil){
		dictionary[kClasseInvitation] = self.invitation;
	}
	if(self.name != nil){
		dictionary[kClasseName] = self.name;
	}
	if(self.qrcode != nil){
		dictionary[kClasseQrcode] = self.qrcode;
	}
	if(self.root != nil){
		dictionary[kClasseRoot] = self.root;
	}
	if(self.schoolid != nil){
		dictionary[kClasseSchoolid] = self.schoolid;
	}
	if(self.tag != nil){
		dictionary[kClasseTag] = self.tag;
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
	if(self.announcement != nil){
		[aCoder encodeObject:self.announcement forKey:kClasseAnnouncement];
	}
	if(self.createtime != nil){
		[aCoder encodeObject:self.createtime forKey:kClasseCreatetime];
	}
	if(self.head != nil){
		[aCoder encodeObject:self.head forKey:kClasseHead];
	}
	[aCoder encodeObject:@(self.idField) forKey:kClasseIdField];	if(self.invitation != nil){
		[aCoder encodeObject:self.invitation forKey:kClasseInvitation];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kClasseName];
	}
	if(self.qrcode != nil){
		[aCoder encodeObject:self.qrcode forKey:kClasseQrcode];
	}
	if(self.root != nil){
		[aCoder encodeObject:self.root forKey:kClasseRoot];
	}
	if(self.schoolid != nil){
		[aCoder encodeObject:self.schoolid forKey:kClasseSchoolid];
	}
	if(self.tag != nil){
		[aCoder encodeObject:self.tag forKey:kClasseTag];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.announcement = [aDecoder decodeObjectForKey:kClasseAnnouncement];
	self.createtime = [aDecoder decodeObjectForKey:kClasseCreatetime];
	self.head = [aDecoder decodeObjectForKey:kClasseHead];
	self.idField = [[aDecoder decodeObjectForKey:kClasseIdField] integerValue];
	self.invitation = [aDecoder decodeObjectForKey:kClasseInvitation];
	self.name = [aDecoder decodeObjectForKey:kClasseName];
	self.qrcode = [aDecoder decodeObjectForKey:kClasseQrcode];
	self.root = [aDecoder decodeObjectForKey:kClasseRoot];
	self.schoolid = [aDecoder decodeObjectForKey:kClasseSchoolid];
	self.tag = [aDecoder decodeObjectForKey:kClasseTag];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Classe *copy = [Classe new];

	copy.announcement = [self.announcement copy];
	copy.createtime = [self.createtime copy];
	copy.head = [self.head copy];
	copy.idField = self.idField;
	copy.invitation = [self.invitation copy];
	copy.name = [self.name copy];
	copy.qrcode = [self.qrcode copy];
	copy.root = [self.root copy];
	copy.schoolid = [self.schoolid copy];
	copy.tag = [self.tag copy];

	return copy;
}
@end