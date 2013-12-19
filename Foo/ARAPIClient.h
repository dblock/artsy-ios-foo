//
//  ARAPIClient.h
//  Foo
//
//  Created by Daniel Doubrovkine on 12/19/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "AFHTTPClient.h"

@interface ARAPIClient : AFHTTPClient

+(ARAPIClient *) sharedClient;
-(void) getXappToken:(void(^)())success;
-(void) getShows:(void(^)(NSArray *shows))success;

@property (nonatomic, copy) NSString *xappToken;

@end
