//
//  FOOSettingsTests.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/19/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FOOSettings.h"

@interface FOOSettingsTests : XCTestCase

@end

@implementation FOOSettingsTests

- (void)testSharedInstance
{
    XCTAssertNotNil([FOOSettings sharedSettings], @"Missing shared settings.");
    XCTAssertEqual([FOOSettings sharedSettings], [FOOSettings sharedSettings], @"Not a singleton.");
}

- (void)testClientId
{
    NSString *clientId = [[FOOSettings sharedSettings] objectForKey:@"client_id"];
    XCTAssertNotNil(clientId, @"Missing client id.");
    XCTAssertTrue([clientId length] > 0, @"Empty client id.");
}

- (void)testClientSecret
{
    NSString *clientSecret = [[FOOSettings sharedSettings] objectForKey:@"client_secret"];
    XCTAssertNotNil(clientSecret, @"Missing client secret.");
    XCTAssertTrue(clientSecret.length > 0, @"Empty client secret.");
}

- (void)testObjectForKey
{
    XCTAssertNil([[FOOSettings sharedSettings] objectForKey:@"does not exist"], @"Value for key should be nil.");
}

@end
