//
//  ThisForThatTests.m
//  ThisForThatTests
//
//  Created by Kyle Shewchuk on 2013-03-05.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ThisForThatTests.h"
#import "JSONInterface.h"
#import "ListingData.h"
#import "OfferData.h"
#import "UserData.h"

@implementation ThisForThatTests

- (void)setUp
{
    [super setUp];

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testInitListings
{
    assert(JSONInterface.listings != nil);
    assert(JSONInterface.listings.count != 0);
}

- (void) testInitOffers
{
    assert(JSONInterface.offers != nil);
    assert(JSONInterface.offers.count != 0);
}

- (void) testInitUsers
{
    assert(JSONInterface.users != nil);
    assert(JSONInterface.users.count != 0);
}


-(void)testGetListing
{
    ListingData *l = [JSONInterface.listings objectAtIndex:0];
    assert(l);
    //assert(l.id);
    assert(l.title);
    assert(l.description);
    assert(l.photo);
    //assert(l.trade_completed);
    assert(l.date_created);
    //assert(l.date_completed);
}

-(void)testGetOffer
{
    OfferData *o = [JSONInterface.offers objectAtIndex:0];
    assert(o);
    //assert(o.id);
    assert(o.title);
    assert(o.description);
    assert(o.photo);
    //assert(o.offer_accepted);
    assert(o.date_created);
    //assert(o.date_accepted);
}

-(void)testGetUsers
{
    UserData *u = [JSONInterface.users objectAtIndex:0];
    assert(u);
    //assert(u.id);
    assert(u.username);
    assert(u.email);

}

-(void) testAddListing
{
    int origCount = JSONInterface.listings.count;
    ListingData *l = [[ListingData alloc] initWithData:@"1" title:@"Tester" description:@"This is a test" photo:@"listing_photos/test.jpg" trade_completed:0 date_created: @"" date_completed: @""];
    
    [JSONInterface addListing:l ];
    assert(JSONInterface.listings.count == origCount +1);
    
    ListingData *l2 = [JSONInterface.listings objectAtIndex:origCount];
    
    assert(l);
    assert(l2);
    assert(l.lid == l2.lid);
    assert(l.title == l2.title);
    assert(l.description == l2.description);
    assert(l.photo == l2.photo);
    assert(l.trade_completed == l2.trade_completed);
    assert(l.date_created == l2.date_created);
    assert(l.date_completed == l2.date_completed);   
}

-(void) testAddOffer
{
    int origCount = JSONInterface.offers.count;
    OfferData *o = [[OfferData alloc] initWithData:@"1" title:@"Tester" description:@"This is a test" photo:@"listing_photos/test.jpg" offer_accepted: 0 date_created: @"" date_accepted: @""];
    
    [JSONInterface addOffer:o];
    assert(JSONInterface.offers.count == origCount +1);
    
    OfferData *o2 = [JSONInterface.offers objectAtIndex:origCount];
    
    assert(o);
    assert(o2);
    assert(o.oid == o2.oid);
    assert(o.title == o2.title);
    assert(o.description == o2.description);
    assert(o.photo == o2.photo);
    assert(o.offer_accepted == o2.offer_accepted);
    assert(o.date_created == o2.date_created);
    assert(o.date_accepted == o2.date_accepted);
}

-(void) testAddUser
{
    int origCount = JSONInterface.users.count;
    UserData *u = [[UserData alloc] initWithData:@"1" username:@"test user" email:@"test@test.com" ];
    
    [JSONInterface addUser:u];
    assert(JSONInterface.users.count == origCount +1);
    
    UserData *u2 = [JSONInterface.users objectAtIndex:origCount];
    
    assert(u);
    assert(u2);
    assert(u.uid == u2.uid);
    assert(u.username = u2.username);
    assert(u.email = u2.email);

}

@end
