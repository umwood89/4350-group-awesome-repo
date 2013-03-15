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
@synthesize descriptions = _description;
@synthesize photo = _photo;
@synthesize offer_accepted = _offer_accepted;
@synthesize date_created = _date_created;
@synthesize date_accepted = _date_accepted;

- (id) initWithData:(NSString*)title description:(NSString*)description photo:(NSURL *)photo
	offer_accepted:(BOOL)offer_accepted date_created:(NSDate *)date_created date_accepted:(NSDate *)date_accepted
{
	self.title = title;
	self.description = description;
	self.photo = photo;
	self.offer_accepted = offer_accepted;
	self.date_created = date_created;
	self.date_accepted = date_accepted;
}
@end
