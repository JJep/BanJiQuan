//
//	User.m
//
//	Create by Jep Xia on 25/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "User.h"

NSString *const kUserArea = @"area";
NSString *const kUserCode = @"code";
NSString *const kUserCodetime = @"codetime";
NSString *const kUserCreatetime = @"createtime";
NSString *const kUserDescriptionField = @"description";
NSString *const kUserHead = @"head";
NSString *const kUserIdField = @"id";
NSString *const kUserfIdField = @"fid";
NSString *const kUserIdentity = @"identity";
NSString *const kUserPassword = @"password";
NSString *const kUserPhonenumber = @"phonenumber";
NSString *const kUserQrcode = @"qrcode";
NSString *const kUserSex = @"sex";
NSString *const kUserStatus = @"status";
NSString *const kUserUsername = @"username";
NSString *const kUserfUsername = @"fusername";


@interface User ()
@end
@implementation User




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kUserArea] isKindOfClass:[NSNull class]]){
		self.area = dictionary[kUserArea];
	}	
	if(![dictionary[kUserCode] isKindOfClass:[NSNull class]]){
		self.code = dictionary[kUserCode];
	}	
	if(![dictionary[kUserCodetime] isKindOfClass:[NSNull class]]){
		self.codetime = dictionary[kUserCodetime];
	}
	if(![dictionary[kUserDescriptionField] isKindOfClass:[NSNull class]]){
		self.descriptionField = dictionary[kUserDescriptionField];
	}	
	if(![dictionary[kUserHead] isKindOfClass:[NSNull class]]){
		self.head = dictionary[kUserHead];
	}	
	if(![dictionary[kUserIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kUserIdField] integerValue];
	}
    if(![dictionary[kUserfIdField] isKindOfClass:[NSNull class]]){
        self.fidField = [dictionary[kUserfIdField] integerValue];
    }
	if(![dictionary[kUserIdentity] isKindOfClass:[NSNull class]]){
		self.identity = dictionary[kUserIdentity];
	}	
	if(![dictionary[kUserPassword] isKindOfClass:[NSNull class]]){
		self.password = dictionary[kUserPassword];
	}	
	if(![dictionary[kUserPhonenumber] isKindOfClass:[NSNull class]]){
		self.phonenumber = dictionary[kUserPhonenumber];
	}	
	if(![dictionary[kUserQrcode] isKindOfClass:[NSNull class]]){
		self.qrcode = dictionary[kUserQrcode];
	}	
	if(![dictionary[kUserSex] isKindOfClass:[NSNull class]]){
		self.sex = dictionary[kUserSex];
	}	
	if(![dictionary[kUserStatus] isKindOfClass:[NSNull class]]){
		self.status = dictionary[kUserStatus];
	}	
	if(![dictionary[kUserUsername] isKindOfClass:[NSNull class]]){
		self.username = dictionary[kUserUsername];
	}
    if(![dictionary[kUserfUsername] isKindOfClass:[NSNull class]]){
        self.fusername = dictionary[kUserfUsername];
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
		dictionary[kUserArea] = self.area;
	}
	if(self.code != nil){
		dictionary[kUserCode] = self.code;
	}
	if(self.codetime != nil){
		dictionary[kUserCodetime] = self.codetime;
	}
	dictionary[kUserCreatetime] = @(self.createtime);
	if(self.descriptionField != nil){
		dictionary[kUserDescriptionField] = self.descriptionField;
	}
	if(self.head != nil){
		dictionary[kUserHead] = self.head;
	}
	dictionary[kUserIdField] = @(self.idField);
	if(self.identity != nil){
		dictionary[kUserIdentity] = self.identity;
	}
	if(self.password != nil){
		dictionary[kUserPassword] = self.password;
	}
	if(self.phonenumber != nil){
		dictionary[kUserPhonenumber] = self.phonenumber;
	}
	if(self.qrcode != nil){
		dictionary[kUserQrcode] = self.qrcode;
	}
	if(self.sex != nil){
		dictionary[kUserSex] = self.sex;
	}
	if(self.status != nil){
		dictionary[kUserStatus] = self.status;
	}
	if(self.username != nil){
		dictionary[kUserUsername] = self.username;
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
		[aCoder encodeObject:self.area forKey:kUserArea];
	}
	if(self.code != nil){
		[aCoder encodeObject:self.code forKey:kUserCode];
	}
	if(self.codetime != nil){
		[aCoder encodeObject:self.codetime forKey:kUserCodetime];
	}
	[aCoder encodeObject:@(self.createtime) forKey:kUserCreatetime];	if(self.descriptionField != nil){
		[aCoder encodeObject:self.descriptionField forKey:kUserDescriptionField];
	}
	if(self.head != nil){
		[aCoder encodeObject:self.head forKey:kUserHead];
	}
	[aCoder encodeObject:@(self.idField) forKey:kUserIdField];	if(self.identity != nil){
		[aCoder encodeObject:self.identity forKey:kUserIdentity];
	}
	if(self.password != nil){
		[aCoder encodeObject:self.password forKey:kUserPassword];
	}
	if(self.phonenumber != nil){
		[aCoder encodeObject:self.phonenumber forKey:kUserPhonenumber];
	}
	if(self.qrcode != nil){
		[aCoder encodeObject:self.qrcode forKey:kUserQrcode];
	}
	if(self.sex != nil){
		[aCoder encodeObject:self.sex forKey:kUserSex];
	}
	if(self.status != nil){
		[aCoder encodeObject:self.status forKey:kUserStatus];
	}
	if(self.username != nil){
		[aCoder encodeObject:self.username forKey:kUserUsername];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.area = [aDecoder decodeObjectForKey:kUserArea];
	self.code = [aDecoder decodeObjectForKey:kUserCode];
	self.codetime = [aDecoder decodeObjectForKey:kUserCodetime];
	self.createtime = [[aDecoder decodeObjectForKey:kUserCreatetime] integerValue];
	self.descriptionField = [aDecoder decodeObjectForKey:kUserDescriptionField];
	self.head = [aDecoder decodeObjectForKey:kUserHead];
	self.idField = [[aDecoder decodeObjectForKey:kUserIdField] integerValue];
	self.identity = [aDecoder decodeObjectForKey:kUserIdentity];
	self.password = [aDecoder decodeObjectForKey:kUserPassword];
	self.phonenumber = [aDecoder decodeObjectForKey:kUserPhonenumber];
	self.qrcode = [aDecoder decodeObjectForKey:kUserQrcode];
	self.sex = [aDecoder decodeObjectForKey:kUserSex];
	self.status = [aDecoder decodeObjectForKey:kUserStatus];
	self.username = [aDecoder decodeObjectForKey:kUserUsername];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	User *copy = [User new];

	copy.area = [self.area copy];
	copy.code = [self.code copy];
	copy.codetime = [self.codetime copy];
	copy.createtime = self.createtime;
	copy.descriptionField = [self.descriptionField copy];
	copy.head = [self.head copy];
	copy.idField = self.idField;
	copy.identity = [self.identity copy];
	copy.password = [self.password copy];
	copy.phonenumber = [self.phonenumber copy];
	copy.qrcode = [self.qrcode copy];
	copy.sex = [self.sex copy];
	copy.status = [self.status copy];
	copy.username = [self.username copy];

	return copy;
}
@end
