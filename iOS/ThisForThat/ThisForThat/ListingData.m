//
//  ListingData.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ListingData.h"

@implementation ListingData
@synthesize title = _title;
@synthesize description = _description;
@synthesize photo = _photo;
@synthesize date_created = _date_created;



- (id)initWithData:(NSString*)title description:(NSString *)description {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
    }
    return self;
}

- (id) initWithData:(NSString*)title description:(NSString*)description photo:(NSURL *)photo date_created:(NSString*)date_created{
    if ((self = [super init])) {
	self.title = title;
	self.description = description;
	self.photo = photo;
	self.date_created = date_created;
    }
    return self;
}


@end
