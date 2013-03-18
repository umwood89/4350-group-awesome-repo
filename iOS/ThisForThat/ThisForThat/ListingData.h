//
//  ListingData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListingData : NSObject

@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSString *photo;
@property (assign) BOOL trade_completed;
@property (strong) NSString *date_created;
@property (strong) NSString *date_completed;



- (id)initWithData:(NSString*)title description:(NSString*)description;

- (id) initWithData:(NSString*)title description:(NSString*)description photo:(NSURL *)photo trade_completed:(BOOL) trade_completed date_created:(NSString*)date_created date_completed:(NSString *)date_completed;

@end
