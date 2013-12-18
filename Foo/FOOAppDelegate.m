//
//  FOOAppDelegate.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/18/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "FOOAppDelegate.h"
#import "FOOMasterViewController.h"
#import "FOOShow.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"

@implementation FOOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    FOOMasterViewController *masterViewController = [[FOOMasterViewController alloc] init];
    [self fetchShows:^(NSArray *shows) {
        masterViewController.shows = shows;
    }];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
    self.window = window;
    return YES;
}

- (void)getXappToken :(void(^)(NSString *token))completion
{
    NSURL * baseURL = [[NSURL alloc] initWithString:@"https://artsy.net"];
    
    NSDictionary *clientParams = @{
      @"client_id": @"fc8f3665cfca82d588ed",
      @"client_secret": @"df6b407fd97e3c5859d88f6e759d686c"
    };
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    NSURLRequest *request = [client requestWithMethod:@"GET" path:@"/api/v1/xapp_token" parameters:clientParams];
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        if (completion) completion(responseObject[@"xapp_token"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        // TODO: show a UIAlertView
        exit(-1);
    }];
    [operation start];
}

- (void)fetchShows :(void(^)(NSArray *shows))completion
{
    [self getXappToken:^(NSString *token) {
        NSLog(@"Token: %@", token);

        NSURL * baseURL = [[NSURL alloc] initWithString:@"https://artsy.net"];
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        NSDictionary *clientParams = @{
          @"xapp_token": token,
          @"size": @(5)
        };
        NSURLRequest *request = [client requestWithMethod:@"GET" path:@"/api/v1/shows" parameters:clientParams];
        AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Response: %@", responseObject);
            NSMutableArray * shows = [NSMutableArray array];
            for (id object in responseObject) {
                FOOShow * show = [[FOOShow alloc] init];
                show.name = object[@"name"];
                [shows addObject:show];
            }
            if (completion) completion(shows);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            // TODO: show a UIAlertView
            exit(-1);
        }];
        [operation start];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
