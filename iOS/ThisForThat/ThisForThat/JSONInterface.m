//
//  JSONInterface.m
//  ThisForThat
//
//  Created by  on 3/14/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "JSONInterface.h"
#import "ASIHTTPRequest.h"
#import "OfferData.h"
#import "ListingData.h"
#import "UserData.h"

@implementation JSONInterface

static NSMutableArray *offers = nil;
static NSMutableArray *listings = nil;
static NSMutableArray *users = nil;


+ (NSMutableArray *)offers
{
    if(offers == nil)
    {
        offers = [self initFromJSON:@"offers" ];
    }
    
    return offers;
}

+ (NSMutableArray *)listings
{
    if(listings == nil)
    {
        listings = [self initFromJSON:@"listings" ];
    }
    
    return listings;
}

+ (NSMutableArray *)users
{
    if(users == nil)
    {
        users = [self initFromJSON:@"users" ];
    }
    
    return users;
}


//Function that will initialize either listings, users, or offers from the json posted by the webserver
+ (NSMutableArray *)initFromJSON:(NSString *)url
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    
    NSMutableString *tempUrl = [[NSMutableString alloc] initWithString:@"http://hackshack.ca/api/"];
    [tempUrl appendString:url];
    
    NSURL *finalUrl = [NSURL URLWithString:tempUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:finalUrl];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options :NSJSONReadingMutableContainers error: &e];
        
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            for(NSDictionary *item in jsonArray) {
                [self addDataToList:url list:list item:item];
            }
        }
        
    } else {
        //error checking
    }
    
    return list;
}

//helper function to add to the list based on object type
+ (void) addDataToList:(NSString *)type list:(NSMutableArray *) list item:(NSDictionary *) item
{
    if([type isEqualToString: @"offers"])
    {
        NSString *oid = [item objectForKey:@"offer_id"];
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        NSString *photo = [item objectForKey:@"photo"];
        NSString *offer_accepted = [item objectForKey:@"offer_accepted"];
        NSString *date_created = [item objectForKey:@"date_created"];
        NSString *date_accepted = [item objectForKey:@"date_accepted"];
        
        OfferData *data = [[OfferData alloc] initWithData:oid title:title description:description photo:photo offer_accepted:offer_accepted date_created:date_created date_accepted:date_accepted];
    
        [list addObject:data];
    }
    else if([type isEqualToString: @"listings"])
    {
        NSString *lid = [item objectForKey:@"listing_id"];
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        NSString *photo = [item objectForKey:@"photo"];
        NSString *trade_completed = [item objectForKey:@"trade_completed"];
        NSString *date_created = [item objectForKey:@"date_created"];
        NSString *date_completed = [item objectForKey:@"date_completed"];
        ListingData *data = [[ListingData alloc] initWithData:lid title:title description:description photo:photo trade_completed:trade_completed date_created:date_created date_completed:date_completed ];
        [list addObject:data];
    }
    else if([type isEqualToString: @"users"])
    {
        NSString* uid  = [item objectForKey:@"id"];
        NSString *username = [item objectForKey:@"username"];
        NSString *email = [item objectForKey:@"email"];
        UserData *data = [[UserData alloc] initWithData:uid username:username email:email ];
        [list addObject:data];
    }
    else
    {
        return;
    }
}

+ (ListingData *) getListingByID:(int)lid
{
    for (ListingData *listing in self.listings)
    {
        if (listing.lid.integerValue == lid)
            return listing;
    }
    
    return nil;
}

+ (OfferData *)getOfferByID:(int)oid
{
    for (OfferData *offer in self.offers)
    {
        if (offer.oid.integerValue == oid)
            return offer;
    }
    
    return nil;
}

+ (UserData *)getUserByID:(int)uid
{
    for (UserData *user in self.users)
    {
        if (user.uid.integerValue == uid)
            return user;
    }
    
    return nil;
}

+ (ListingData *) addListing:(ListingData *)toAdd
{
    [listings addObject:toAdd];
    //json adding magic
    
    return nil;
}


+ (OfferData *) addOffer:(OfferData *)toAdd
{
    
    [offers addObject:toAdd];
    //json adding magic
    
    return nil;
    
}


+ (UserData *) addUser:(UserData *)toAdd
{
    
    [users addObject:toAdd];
    //json adding magic
    
    return nil;
    
}

 
 

@end
