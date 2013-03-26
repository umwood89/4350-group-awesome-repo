//
//  OfferData.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "OfferData.h"


@implementation OfferData

@synthesize title = _title;
@synthesize description = _description;
@synthesize photo = _photo;
@synthesize offer_accepted = _offer_accepted;
@synthesize date_created = _date_created;
@synthesize date_accepted = _date_accepted;
@synthesize listing = _listing;
@synthesize user = _user;


- (id)initWithData:(NSString*)title description:(NSString *)description {
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
    }
    return self;
}

- (id) initWithData:(int)oid title:(NSString*)title description:(NSString*)description photo:(NSString *)photo offer_accepted:(NSString *)offer_accepted date_created:(NSString *)date_created date_accepted:(NSString *)date_accepted listing:(int)listing user:(int)user
{
    self.oid = oid;
	self.title = title;
	self.description = description;
	self.photo = photo;
	self.offer_accepted = offer_accepted;
	self.date_created = date_created;
	self.date_accepted = date_accepted;
    self.listing = listing;
    self.user = user;
    
    return self;
}

- (id)initWithData:(NSString*)title description:(NSString *)description user:(int)user listing:(int)listing
{
    if ((self = [super init])) {
        self.title = title;
        self.description = description;
        self.user = user;
        self.listing = listing;
    }
    return self;
}


@end
