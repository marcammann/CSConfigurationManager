//
//  CSConfigurationManager.h
//  CSConfigurationManager
//
//  Created by Marc Ammann on 3/7/12.
//  Copyright (c) 2013 Marc Ammann. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *HGPercentEncodedStringFromStringWithEncoding(NSString *string, NSStringEncoding encoding);

/**
 The Default key for values that are being read when the value doesn't exist
 */
extern NSString * const HGConfigurationManagerDefaultKey;


@interface HGConfigurationManager : NSObject

/**
 The configuration string to use, defaults to your ${CONFIGURATION} value
 */
@property (nonatomic, copy) NSString *configuration;


/**
 Default initializer, needs a path to a plist
 */
- (id)initWithContentsOfURL:(NSURL *)url;


/**
 Get the value in the bundle for the configured configuration.
 */
- (id)valueForKey:(NSString *)key;


/**
 Gets the object in the bundle for configured configuration
 */
- (id)objectForKey:(NSString *)key;


/**
 Gets configured Configuration for the path and parameters
 */
- (NSString *)configurationValueForIdentifier:(NSString *)pathIdentifier parameters:(NSDictionary *)pathParameters;

@end
