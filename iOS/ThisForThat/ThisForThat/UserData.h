//
//  UserData.h
//  ThisForThat
//
//  Created by Walter Fotiuk on 3/17/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property int uid;
@property (strong) NSString *username;
@property (strong) NSString *email;


- (id)initWithData:(int)uid username:(NSString*)username email:(NSString*)email;

- (BOOL)isEmpty;


@end
