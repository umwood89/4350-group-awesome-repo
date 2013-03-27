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
    ListingData *l = [[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1];
    
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    
    [JSONInterface addListing:l imageData:UIImagePNGRepresentation(image) ];
    assert(JSONInterface.listings.count == origCount +1);
    
    ListingData *l2 = [JSONInterface.listings objectAtIndex:origCount];
    
    assert(l);
    assert(l2);
    assert(l2.lid != 0);
    assert(l.title == l2.title);
    assert(l.description == l2.description);
    assert(l.photo == l2.photo);
    assert(l.trade_completed == l2.trade_completed);
    assert(l.date_created == l2.date_created);
    assert(l.date_completed == l2.date_completed);
    
    [JSONInterface deleteListing:l2];
}

-(void) testAddOffer
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    int origCount = JSONInterface.offers.count;
    
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    
    
    OfferData *o = [[OfferData alloc] initWithData:@"Test title" description:@"Test description" user:1 listing:l.lid];
    
    
    
    [JSONInterface addOffer:o imageData:UIImagePNGRepresentation(image) ];
    assert(JSONInterface.offers.count == origCount +1);
    
    OfferData *o2 = [JSONInterface.offers objectAtIndex:origCount];
    
    assert(o);
    assert(o2);
    assert(o2.oid != 0);
    assert(o.title == o2.title);
    assert(o.description == o2.description);
    assert(o.photo == o2.photo);
    assert(o.offer_accepted == o2.offer_accepted);
    assert(o.date_created == o2.date_created);
    assert(o.date_accepted == o2.date_accepted);
    
    [JSONInterface deleteListing:l];
}

-(void) testAddUser
{
    int origCount = JSONInterface.users.count;
    UserData *u = [[UserData alloc] initWithData:1 username:@"test user" email:@"test@test.com" ];
    
    [JSONInterface addUser:u];
    assert(JSONInterface.users.count == origCount +1);
    
    UserData *u2 = [JSONInterface.users objectAtIndex:origCount];
    
    assert(u);
    assert(u2);
    assert(u.uid == u2.uid);
    assert(u.username = u2.username);
    assert(u.email = u2.email);

}

-(void) testCancelOffer
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    OfferData *o = [JSONInterface addOffer:[[OfferData alloc] initWithData:@"Test title" description:@"Test description" user:1 listing:l.lid] imageData:UIImagePNGRepresentation(image)];
    
                    
    [JSONInterface cancelOffer:o];
    assert([JSONInterface getOfferByID:o.oid] == nil);
    [JSONInterface deleteListing:l];
}

-(void) testDeleteListing
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];

    [JSONInterface deleteListing:l];
    assert([JSONInterface getListingByID:l.lid] == nil);
}

-(void) testCancelOffersWhenDeleteListing
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    
    
    OfferData *o = [JSONInterface addOffer:[[OfferData alloc] initWithData:@"Test title" description:@"Test description" user:1 listing:l.lid] imageData:UIImagePNGRepresentation(image)];
    OfferData *o1 = [JSONInterface addOffer:[[OfferData alloc] initWithData:@"Test title2" description:@"Test description2" user:1 listing:l.lid] imageData:UIImagePNGRepresentation(image)];
    OfferData *o2 = [JSONInterface addOffer:[[OfferData alloc] initWithData:@"Test title3" description:@"Test description3" user:1 listing:l.lid] imageData:UIImagePNGRepresentation(image)];
    
    [JSONInterface deleteListing:l];
    
    assert([JSONInterface getOfferByID:o.oid] == nil);
    assert([JSONInterface getOfferByID:o1.oid] == nil);
    assert([JSONInterface getOfferByID:o2.oid] == nil);

}

-(void) testUpdateListing
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    
    NSString *newTitle = @"updated title";
    NSString *newDescription = @"updated description";
    int newUser = 2;
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    
        
    l.title = newTitle;
    l.description = newDescription;
    l.user = newUser;
    
    [JSONInterface updateListing:l imageData:UIImagePNGRepresentation(image)];
    
    ListingData *l2 = [JSONInterface getListingByID:l.lid];
    
    assert(l2.title == newTitle);
    assert(l2.description == newDescription);
    assert(l2.user == newUser);
    
    [JSONInterface deleteListing:l2];
}

-(void) testUpdateOffer
{
    UIImage *image = [UIImage imageNamed:@"130-dice.png"];
    
    NSString *newTitle = @"updated title";
    NSString *newDescription = @"updated description";
    int newUser = 2;
    //need to add a listing first
    ListingData *l = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    ListingData *l2 = [JSONInterface addListing:[[ListingData alloc] initWithData:@"Test title" description:@"Test description" user:1] imageData:UIImagePNGRepresentation(image)];
    
    OfferData *o = [JSONInterface addOffer:[[OfferData alloc] initWithData:@"Test title" description:@"Test description" user:1 listing:l.lid] imageData:UIImagePNGRepresentation(image)];
    
    
    o.title = newTitle;
    o.description = newDescription;
    o.user = newUser;
    o.listing = l2.lid;
    
    [JSONInterface updateOffer:o imageData:UIImagePNGRepresentation(image)];
    
    OfferData *o2 = [JSONInterface getOfferByID:o.oid];
    
    assert(o2.title == newTitle);
    assert(o2.description == newDescription);
    assert(o2.user == newUser);
    assert(o2.listing == l2.lid);
    
    [JSONInterface deleteListing:l];
    [JSONInterface deleteListing:l2];
    [JSONInterface cancelOffer:o2];
}

@end
