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


- (id)initWithContentsOfURL:(NSURL *)url {
	self = [super init];
	if (self) {
		self.dataSource = [[NSDictionary alloc] initWithContentsOfFile:[url path]];
#ifdef BUILD_TARGET
		self.configuration = (NSString *)CFSTR(BUILD_TARGET);
#else
		self.configuration = CSConfigurationManagerDefaultKey;
#endif
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
	// configuration exists, value exists - configuration/key
	if ((confDataSource = [self.dataSource objectForKey:self.configuration]) && (value = [confDataSource objectForKey:key])) {
		return value;
	}
	// check default
	else if ((confDataSource = [self.dataSource objectForKey:CSConfigurationManagerDefaultKey]) && (value = [confDataSource objectForKey:key])) {
		return value;
	}
	// no value at all.
	else {
		return nil;
	}
}


NSString *CSPercentEncodedStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
	static NSString * const kAFLegalCharactersToBeEscaped = @":/.?&=;+!@$()~";
	return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)kAFLegalCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}


- (NSString*)configurationValueForIdentifier:(NSString *)pathIdentifier parameters:(NSDictionary *)pathParameters {

	NSString *path = [self valueForKey:pathIdentifier];
	for (id key in [pathParameters allKeys]) {
		NSString *replacement = CSPercentEncodedStringFromStringWithEncoding([NSString stringWithFormat:@"%@", [pathParameters objectForKey:key]], NSASCIIStringEncoding);
		if (replacement == nil) {
			continue;
		}
		path = [path stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", key] withString:replacement];
	}
	
	return path;
}



@end
