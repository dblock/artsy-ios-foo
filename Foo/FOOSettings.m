//
//  FOOSettings.m
//  Foo
//
//  Created by Daniel Doubrovkine on 12/19/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "FOOSettings.h"

@interface FOOSettings()
@property (nonatomic, copy) NSDictionary *settings;
@end

@implementation FOOSettings

+ (FOOSettings *) sharedSettings
{
    static FOOSettings * settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[FOOSettings alloc] init];
    });
    return settings;
}

-(id) init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        _settings = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    }
    return self;
}

-(id)objectForKey:(id)key
{
    return [self.settings objectForKey:key];
}

@end
