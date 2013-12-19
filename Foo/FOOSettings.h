//
//  FOOSettings.h
//  Foo
//
//  Created by Daniel Doubrovkine on 12/19/13.
//  Copyright (c) 2013 Artsy. All rights reserved.
//

#import "AFHTTPClient.h"

@interface FOOSettings : NSObject

+(FOOSettings *) sharedSettings;
-(id) objectForKey:(id)key;
@end
