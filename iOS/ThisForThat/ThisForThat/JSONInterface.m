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
#import <stdlib.h>
#import "ASIFormDataRequest.h"

@implementation JSONInterface

static NSMutableArray *offers = nil;
static NSMutableArray *listings = nil;
static NSMutableArray *users = nil;
static UserData  *user_logged_in = nil;


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

+ (UserData *)user_logged_in
{
    if(user_logged_in == nil)
    {
        user_logged_in = [[UserData alloc] init] ;
    }
    
    return user_logged_in;
}


+ (NSDictionary *) getDictionaryFromJSON:(NSString *)json
{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *toReturn = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    if(error)
    {
        NSLog(@"%@",error);
        return nil;
    }
    else
        return toReturn;
    
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
        NSDictionary *json = [self getDictionaryFromJSON:response];
        if (json)
        {
            for(NSDictionary *item in json) {
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
        int oid = [[item objectForKey:@"offer_id"] intValue];
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        NSString *photo = [item objectForKey:@"photo"];
        NSString *offer_accepted = [item objectForKey:@"offer_accepted"];
        NSString *date_created = [item objectForKey:@"date_created"];
        NSString *date_accepted = [item objectForKey:@"date_accepted"];
        int listing = [[item objectForKey:@"listing"] intValue];
        int user = [[item objectForKey:@"user"]intValue];
        
        OfferData *data = [[OfferData alloc] initWithData:oid title:title description:description photo:photo offer_accepted:offer_accepted date_created:date_created date_accepted:date_accepted listing:listing user:user];
    
        [list addObject:data];
    }
    else if([type isEqualToString: @"listings"])
    {
        int lid = [[item objectForKey:@"listing_id"] intValue];
        NSString *title = [item objectForKey:@"title"];
        NSString *description = [item objectForKey:@"description"];
        NSString *photo = [item objectForKey:@"photo"];
        int user = [[item objectForKey:@"user"]intValue];
        NSString *trade_completed = [item objectForKey:@"trade_completed"];
        NSString *date_created = [item objectForKey:@"date_created"];
        NSString *date_completed = [item objectForKey:@"date_completed"];
        
        
        ListingData *data = [[ListingData alloc] initWithData:lid title:title description:description photo:photo user:user trade_completed:trade_completed date_created:date_created date_completed:date_completed];
        [list addObject:data];
    }
    else if([type isEqualToString: @"users"])
    {
        int uid  = [[item objectForKey:@"id"] intValue];
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
        if (listing.lid == lid)
            return listing;
    }
    
    return nil;
}

+ (OfferData *)getOfferByID:(int)oid
{
    for (OfferData *offer in self.offers)
    {
        if (offer.oid == oid)
            return offer;
    }
    
    return nil;
}

+ (UserData *)getUserByID:(int)uid
{
    for (UserData *user in self.users)
    {
        if (user.uid == uid)
            return user;
    }
    
    return nil;
}

+ (UserData *)getUserByUsername:(NSString *)username
{
    for (UserData *user in self.users)
    {
        if ([user.username isEqualToString:username])
            return user;
    }
    
    return nil;
}

+ (ListingData *) addListing:(ListingData *)toAdd imageData:(NSData *)imageData
{
    NSString *filename = [NSString stringWithFormat:@"%i.jpg",arc4random() % 50000];
    
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://hackshack.ca/api/listings"]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setPostValue:toAdd.title forKey:@"title"];
    [request setPostValue:toAdd.description forKey:@"description"];
    [request setPostValue:[NSString stringWithFormat:@"%i",toAdd.user] forKey:@"user"];
    [request addData:imageData withFileName:filename andContentType:@"image/jpeg" forKey:@"photo"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONLogin response: %@", response);
    
    NSDictionary *responseJSON = [self getDictionaryFromJSON:response];
    
    toAdd.photo = [responseJSON objectForKey:@"photo"];
    toAdd.date_created = [responseJSON objectForKey:@"date_created"];
    toAdd.lid = [[responseJSON objectForKey:@"listing_id"]intValue];
    
    [[self listings] addObject:toAdd];
    
    
    
    
    return toAdd;
}


+ (ListingData *) updateListing:(ListingData *)toAdd imageData:(NSData *)imageData
{
    NSString *filename = [NSString stringWithFormat:@"%i.jpg",arc4random() % 50000];
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://hackshack.ca/api/listings/"];
    [url appendString:[NSString stringWithFormat:@"%i",toAdd.lid]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"PATCH"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setPostValue:toAdd.title forKey:@"title"];
    [request setPostValue:toAdd.description forKey:@"description"];
    [request setPostValue:[NSString stringWithFormat:@"%i",toAdd.user] forKey:@"user"];
    [request setPostValue:toAdd.date_completed forKey:@"date_completed"];
    [request setPostValue:toAdd.trade_completed forKey:@"trade_completed"];
    [request addData:imageData withFileName:filename andContentType:@"image/jpeg" forKey:@"photo"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONUpdateListing response: %@", response);
    
    NSDictionary *responseJSON = [self getDictionaryFromJSON:response];
    
    toAdd.photo = [responseJSON objectForKey:@"photo"];
    toAdd.date_created = [responseJSON objectForKey:@"date_created"];
    toAdd.lid = [[responseJSON objectForKey:@"listing_id"]intValue];
    
    [[self listings] addObject:toAdd];
    
    return toAdd;
}

+ (void) deleteListing:(ListingData *)toDelete
{
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://hackshack.ca/api/listings/"];
    [url appendString:[NSString stringWithFormat:@"%i",toDelete.lid]];
    
    [self findAndDeleteAssociatedOffers:toDelete.lid];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"DELETE"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONCancelOffer response: %@", response);
    
    [[self offers] removeObject:toDelete];
    
    
}

+ (void) findAndDeleteAssociatedOffers:(int)listing_id
{
    NSMutableArray *offersCopy = [self.offers copy];
    for (OfferData *offer in offersCopy)
    {
        if (offer.listing == listing_id)
        {
            [self cancelOffer:offer];
        }
    }
}


+ (OfferData *) updateOffer:(OfferData *)toAdd imageData:(NSData *)imageData
{
    NSString *filename = [NSString stringWithFormat:@"%i.jpg",arc4random() % 50000];
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://hackshack.ca/api/offers/"];
    [url appendString:[NSString stringWithFormat:@"%i",toAdd.oid]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"PATCH"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setPostValue:toAdd.title forKey:@"title"];
    [request setPostValue:toAdd.description forKey:@"description"];
    [request setPostValue:[NSString stringWithFormat:@"%i",toAdd.user] forKey:@"user"];
    [request setPostValue:[NSString stringWithFormat:@"%i",toAdd.listing] forKey:@"listing"];
    [request setPostValue:toAdd.date_accepted forKey:@"date_accepted"];
    [request setPostValue:toAdd.offer_accepted forKey:@"offer_accepted"];
    [request addData:imageData withFileName:filename andContentType:@"image/jpeg" forKey:@"photo"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONUpdateOffer response: %@", response);
    
    NSDictionary *responseJSON = [self getDictionaryFromJSON:response];
    
    toAdd.photo = [responseJSON objectForKey:@"photo"];
    toAdd.date_created = [responseJSON objectForKey:@"date_created"];
    
    [[self offers] addObject:toAdd];
    
    return toAdd;
    
}

+ (void) cancelOffer:(OfferData *)toDelete
{
    NSMutableString *url = [[NSMutableString alloc] initWithString:@"http://hackshack.ca/api/offers/"];
    [url appendString:[NSString stringWithFormat:@"%i",toDelete.oid]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setRequestMethod:@"DELETE"];
    [request startSynchronous];
    
    NSString *response = [request responseString];
    NSLog(@"JSONCancelOffer response: %@", response);
    
    [[self offers] removeObject:toDelete];
    
    
}


+ (UserData *) addUser:(UserData *)toAdd
{
    
    [users addObject:toAdd];
    //json adding magic
    
    return nil;
    
}

+ (void) changeLoggedInUser:(UserData *)newUser
{
    user_logged_in = newUser;
    NSLog(@"User changed: %@",newUser.username);
}

+ (NSMutableArray *)getOffersForListing:(int)listing_id
{
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    for (OfferData *offer in [self offers])
    {
        if(offer.listing == listing_id )
        {
            [toReturn addObject:offer];
        }
    }
    
    return toReturn;
}


+ (NSMutableArray *)getListingsForLoggedInUser
{
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    for (ListingData *listing in [self listings])
    {
        if(listing.user == [self user_logged_in].uid )
        {
            [toReturn addObject:listing];
        }
    }
    
    return toReturn;
}

+ (NSMutableArray *)getOffersForLoggedInUser
{
    NSMutableArray *toReturn = [[NSMutableArray alloc] init];
    for (OfferData *offer in [self offers])
    {
        if(offer.user == [self user_logged_in].uid )
        {
            [toReturn addObject:offer];
        }
    }
    
    return toReturn;
}

+ (NSString *) rightNowInString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    [formatter release];
    
    return dateString;
}

    
 
 

@end
