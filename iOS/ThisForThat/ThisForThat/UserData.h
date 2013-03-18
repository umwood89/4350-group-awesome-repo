//
//  UserData.h
//  ThisForThat
//
//  Created by Walter Fotiuk on 3/17/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property (strong) NSString *uid;
@property (strong) NSString *username;
@property (strong) NSString *email;


- (id)initWithData:(NSString *)uid username:(NSString*)username email:(NSString*)email;


@end
