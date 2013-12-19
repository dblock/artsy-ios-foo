//
//  ARAPIClient.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/19/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "ARAPIClient.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "FooShow.h"

@implementation ARAPIClient

+ (ARAPIClient *) sharedClient
{
    static ARAPIClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL * baseURL = [[NSURL alloc] initWithString:@"https://artsy.net"];
        client = [[ARAPIClient alloc] initWithBaseURL:baseURL];
    });
    return client;
}

- (void) getXappToken:(void(^)())success
{
    __weak typeof(self) weakSelf = self;
    NSDictionary *clientParams = @{@"client_id": @"fc8f3665cfca82d588ed", @"client_secret": @"df6b407fd97e3c5859d88f6e759d686c"};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"/api/v1/xapp_token" parameters:clientParams];
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        weakSelf.xappToken = responseObject[@"xapp_token"];
        if (success) success();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        // TODO: show a UIAlertView
        exit(-1);
    }];
    [operation start];
}

- (void) getShows:(void(^)(NSArray *shows))success
{
    NSDictionary *clientParams = @{@"xapp_token": self.xappToken, @"size": @(5)};
    NSURLRequest *request = [self requestWithMethod:@"GET" path:@"/api/v1/shows" parameters:clientParams];
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        NSMutableArray * shows = [NSMutableArray array];
        for (id object in responseObject) {
            // TODO: use Mantle to transform JSON to an object
            FOOShow * show = [[FOOShow alloc] init];
            show.name = object[@"name"];
            [shows addObject:show];
        }
        if (success) success(shows);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        // TODO: show a UIAlertView
        exit(-1);
    }];
    [operation start];
}

@end

