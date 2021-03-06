//
//  ListingData.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ListingData.h"

@implementation ListingData
@synthesize lid = _lid;
@synthesize title = _title;
@synthesize description = _description;
@synthesize photo = _photo;
@synthesize trade_completed = _trade_completed;
@synthesize date_created = _date_created;
@synthesize date_completed = _date_completed;
@synthesize user = _user;




- (id)initWithData:(NSString*)title description:(NSString *)description {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
    }
    return self;
}

- (id)initWithData:(NSString*)title description:(NSString*)description user:(int)user
{
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.user = user;
    }
    return self;
}

- (id) initWithData:(int)lid title:(NSString*)title description:(NSString*)description photo:(NSString *)photo user:(int)user trade_completed:(NSString *) trade_completed date_created:(NSString*)date_created date_completed:(NSString *)date_completed
{
    if ((self = [super init]))
    {
        self.lid = lid;
        self.title = title;
        self.description = description;
        self.photo = photo;
        self.trade_completed = trade_completed;
        self.date_created = date_created;
        self.date_completed = date_completed;
        self.user = user;
    }
    return self;
}


@end
