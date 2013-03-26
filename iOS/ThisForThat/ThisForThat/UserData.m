//
//  UserData.m
//  ThisForThat
//
//  Created by Walter Fotiuk on 3/17/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "UserData.h"

@implementation UserData

@synthesize uid = _uid;
@synthesize username = _username;
@synthesize email = _email;

- (id)initWithData:(int)uid username:(NSString*)username email:(NSString *)email {
    if ((self = [super init])) {
        self.uid = uid;
        self.username = username;
        self.email = email;
    }
    return self;
}

- (BOOL)isEmpty
{
    if(self.username == nil && self.email == nil)
        return TRUE;
    return FALSE;
}

@end
