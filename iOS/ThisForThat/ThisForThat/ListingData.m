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

- (id)initWithData:(NSString*)title description:(NSString *)description {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
    }
    return self;
}

@end
