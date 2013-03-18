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

@implementation JSONInterface

static NSMutableArray *offersList = nil;
static NSMutableArray *listingsList = nil;
static NSMutableArray *usersList = nil;


+ (NSMutableArray *)offers
{
    if(offersList == nil)
    {
        offersList = [self initFromJSON:@"offers" ];
    }
    
    return offersList;
}

+ (NSMutableArray *)listings
{
    if(listingsList == nil)
    {
        listingsList = [self initFromJSON:@"listings" ];
    }
    
    return listingsList;
}

+ (NSMutableArray *)users
{
    if(usersList == nil)
    {
        usersList = [self initFromJSON:@"users" ];
    }
    
    return usersList;
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
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        
        OfferData *data = [[OfferData alloc] initWithData:title description:description];
        [list addObject:data];
    }
    else if([type isEqualToString: @"listings"])
    {
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        NSString *photo = [item objectForKey:@"photo"];
        NSDate *date_created = [item objectForKey:@"date_created"];
        ListingData *data = [[ListingData alloc] initWithData:title description:description photo:photo date_created:date_created ];
        [list addObject:data];
    }
    else if([type isEqualToString: @"users"])
    {
        return; //for now
    }
    else
    {
        return;
    }
}

/*

+ (ListingData *) getListingByID:(int)id
{
    for (ListingData *listing in self.listings)
    {
        if (listing.id == id)
            return listing;
    }
    
    return nil;
}

+ (OfferData *)getOfferByID:(int)id
{
    for (OfferData *offer in self.offers)
    {
        if (offer.id == id)
            return offer;
    }
    
    return nil;
}

+ (UserData *)getUserByID:(int)id
{
    for (UserData *user in self.users)
    {
        if (user.id == id)
            return user;
    }
    
    return nil;
}

*/
 
 

@end
