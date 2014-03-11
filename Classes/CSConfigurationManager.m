//
//  CSConfigurationManager.m
//  CSConfigurationManager
//
//  Created by Marc Ammann on 3/7/12.
//  Copyright (c) 2013 Marc Ammann. All rights reserved.
//

#import "CSConfigurationManager.h"

NSString * const CSConfigurationManagerDefaultKey = @"Default";

@interface CSConfigurationManager ()
@property (nonatomic, strong) NSDictionary *dataSource;
@end


@implementation CSConfigurationManager

@synthesize dataSource = dataSource_;
@synthesize configuration = configuration_;


- (instancetype)init {
	self = [super init];
	if (self) {
#ifdef BUILD_TARGET
		self.configuration = (NSString *)CFSTR(BUILD_TARGET);
#else
		self.configuration = CSConfigurationManagerDefaultKey;
#endif
	}

	return self;
}


/**
 Initialize with Plist
 */
- (instancetype)initWithContentsOfPlist:(NSString *)path {
	self = [self init];
	if (self) {
		self.dataSource = [[NSDictionary alloc] initWithContentsOfFile:path];
	}

	return self;
}


/**
 Initialize with JSON
 */
- (id)initWithContentsOfJSON:(NSString *)path {
	self = [self init];
	if (self) {
		self.dataSource = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:0 error:nil];
	}

	return self;
}


- (id)valueForKey:(NSString *)key {
	NSDictionary *confDataSource;
	id value;
	// configuration exists, value exists - configuration/key
	if ((confDataSource = [self.dataSource objectForKey:self.configuration]) && (value = [confDataSource valueForKey:key])) {
		return value;
	}
	// check default
	else if ((confDataSource = [self.dataSource objectForKey:CSConfigurationManagerDefaultKey]) && (value = [confDataSource valueForKey:key])) {
		return value;
	}
	// no value at all.
	else {
		return nil;
	}
}


- (id)objectForKey:(NSString *)key {
	NSDictionary *confDataSource;
	id value;
	
	if ((confDataSource = [self.dataSource objectForKey:self.configuration]) && (value = [confDataSource objectForKey:key])) {
		// configuration exists, value exists - configuration/key
		return value;
	} else if ((confDataSource = [self.dataSource objectForKey:CSConfigurationManagerDefaultKey]) && (value = [confDataSource objectForKey:key])) {
		// check default
		return value;
	} else {
		// no value at all.
		return nil;
	}
}


NSString *CSPercentEncodedStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
	static NSString * const kAFLegalCharactersToBeEscaped = @":/.?&=;+!@$()~";
	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kAFLegalCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}


- (NSString *)valueForKey:(NSString *)key replacements:(NSDictionary *)replacements {
	NSString *value = [self valueForKey:key];
	for (id replacementKey in [replacements allKeys]) {
		NSString *replacement = CSPercentEncodedStringFromStringWithEncoding([NSString stringWithFormat:@"%@", [replacements objectForKey:replacementKey]], NSASCIIStringEncoding);
		if (replacement == nil) {
			continue;
		}
		value = [value stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", replacementKey] withString:replacement];
	}
	
	return value;
}



@end
