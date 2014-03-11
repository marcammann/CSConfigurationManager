//
//  CSConfigurationManagerExampleProjectTests.m
//  CSConfigurationManagerExampleProjectTests
//
//  Created by Marc Ammann on 3/10/14.
//  Copyright (c) 2014 Marc Ammann. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CSConfigurationManager.h"

@interface CSConfigurationManagerExampleProjectTests : XCTestCase

@end

@implementation CSConfigurationManagerExampleProjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Configuration" ofType:@"json"];

	CSConfigurationManager *configurationManager = [[CSConfigurationManager alloc] initWithContentsOfJSON:path];
	XCTAssertNotEqualObjects([configurationManager valueForKey:@"APIVersion"], @"2.x", @"Debug Configuration should use default value for APIVersion");
	XCTAssertNotEqualObjects([configurationManager valueForKey:@"LogLevel"], @"Debug", @"Debug Configuration should use Debug value for LogLevel");
}

@end
