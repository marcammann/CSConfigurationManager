//
//  CSConfigurationManager.h
//  CSConfigurationManager
//
//  Created by Marc Ammann on 3/7/12.
//  Copyright (c) 2013 Marc Ammann. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *CSPercentEncodedStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding);

/**
 The Default key for values that are being read when the value doesn't exist
 */
extern NSString * const CSConfigurationManagerDefaultKey;


@interface CSConfigurationManager : NSObject

/**
 The configuration string to use, defaults to your ${CONFIGURATION} value
 */
@property (nonatomic, copy) NSString *configuration;

/**
 Initialize with Plist file
 */
- (instancetype)initWithContentsOfPlist:(NSString *)path;

/**
 Initialize with JSON file
 */
- (instancetype)initWithContentsOfJSON:(NSString *)path;


/**
 Get the value in the bundle for the configured configuration.
 */
- (id)valueForKey:(NSString *)key;


/**
 Gets the object in the bundle for configured configuration
 */
- (id)objectForKey:(NSString *)key;


/**
 Gets the value for the key and replaces placeholders with replacements
 */
- (NSString *)valueForKey:(NSString *)key replacements:(NSDictionary *)replacements;

@end
