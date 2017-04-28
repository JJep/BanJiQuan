//
//	Codetime.m
//
//	Create by Jep Xia on 18/4/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Codetime.h"

NSString *const kCodetimeDate = @"date";
NSString *const kCodetimeDay = @"day";
NSString *const kCodetimeHours = @"hours";
NSString *const kCodetimeMinutes = @"minutes";
NSString *const kCodetimeMonth = @"month";
NSString *const kCodetimeNanos = @"nanos";
NSString *const kCodetimeSeconds = @"seconds";
NSString *const kCodetimeTime = @"time";
NSString *const kCodetimeTimezoneOffset = @"timezoneOffset";
NSString *const kCodetimeYear = @"year";

@interface Codetime ()
@end
@implementation Codetime




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCodetimeDate] isKindOfClass:[NSNull class]]){
		self.date = [dictionary[kCodetimeDate] integerValue];
	}

	if(![dictionary[kCodetimeDay] isKindOfClass:[NSNull class]]){
		self.day = [dictionary[kCodetimeDay] integerValue];
	}

	if(![dictionary[kCodetimeHours] isKindOfClass:[NSNull class]]){
		self.hours = [dictionary[kCodetimeHours] integerValue];
	}

	if(![dictionary[kCodetimeMinutes] isKindOfClass:[NSNull class]]){
		self.minutes = [dictionary[kCodetimeMinutes] integerValue];
	}

	if(![dictionary[kCodetimeMonth] isKindOfClass:[NSNull class]]){
		self.month = [dictionary[kCodetimeMonth] integerValue];
	}

	if(![dictionary[kCodetimeNanos] isKindOfClass:[NSNull class]]){
		self.nanos = [dictionary[kCodetimeNanos] integerValue];
	}

	if(![dictionary[kCodetimeSeconds] isKindOfClass:[NSNull class]]){
		self.seconds = [dictionary[kCodetimeSeconds] integerValue];
	}

	if(![dictionary[kCodetimeTime] isKindOfClass:[NSNull class]]){
		self.time = [dictionary[kCodetimeTime] integerValue];
	}

	if(![dictionary[kCodetimeTimezoneOffset] isKindOfClass:[NSNull class]]){
		self.timezoneOffset = [dictionary[kCodetimeTimezoneOffset] integerValue];
	}

	if(![dictionary[kCodetimeYear] isKindOfClass:[NSNull class]]){
		self.year = [dictionary[kCodetimeYear] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kCodetimeDate] = @(self.date);
	dictionary[kCodetimeDay] = @(self.day);
	dictionary[kCodetimeHours] = @(self.hours);
	dictionary[kCodetimeMinutes] = @(self.minutes);
	dictionary[kCodetimeMonth] = @(self.month);
	dictionary[kCodetimeNanos] = @(self.nanos);
	dictionary[kCodetimeSeconds] = @(self.seconds);
	dictionary[kCodetimeTime] = @(self.time);
	dictionary[kCodetimeTimezoneOffset] = @(self.timezoneOffset);
	dictionary[kCodetimeYear] = @(self.year);
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
	[aCoder encodeObject:@(self.date) forKey:kCodetimeDate];	[aCoder encodeObject:@(self.day) forKey:kCodetimeDay];	[aCoder encodeObject:@(self.hours) forKey:kCodetimeHours];	[aCoder encodeObject:@(self.minutes) forKey:kCodetimeMinutes];	[aCoder encodeObject:@(self.month) forKey:kCodetimeMonth];	[aCoder encodeObject:@(self.nanos) forKey:kCodetimeNanos];	[aCoder encodeObject:@(self.seconds) forKey:kCodetimeSeconds];	[aCoder encodeObject:@(self.time) forKey:kCodetimeTime];	[aCoder encodeObject:@(self.timezoneOffset) forKey:kCodetimeTimezoneOffset];	[aCoder encodeObject:@(self.year) forKey:kCodetimeYear];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.date = [[aDecoder decodeObjectForKey:kCodetimeDate] integerValue];
	self.day = [[aDecoder decodeObjectForKey:kCodetimeDay] integerValue];
	self.hours = [[aDecoder decodeObjectForKey:kCodetimeHours] integerValue];
	self.minutes = [[aDecoder decodeObjectForKey:kCodetimeMinutes] integerValue];
	self.month = [[aDecoder decodeObjectForKey:kCodetimeMonth] integerValue];
	self.nanos = [[aDecoder decodeObjectForKey:kCodetimeNanos] integerValue];
	self.seconds = [[aDecoder decodeObjectForKey:kCodetimeSeconds] integerValue];
	self.time = [[aDecoder decodeObjectForKey:kCodetimeTime] integerValue];
	self.timezoneOffset = [[aDecoder decodeObjectForKey:kCodetimeTimezoneOffset] integerValue];
	self.year = [[aDecoder decodeObjectForKey:kCodetimeYear] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Codetime *copy = [Codetime new];

	copy.date = self.date;
	copy.day = self.day;
	copy.hours = self.hours;
	copy.minutes = self.minutes;
	copy.month = self.month;
	copy.nanos = self.nanos;
	copy.seconds = self.seconds;
	copy.time = self.time;
	copy.timezoneOffset = self.timezoneOffset;
	copy.year = self.year;

	return copy;
}
@end