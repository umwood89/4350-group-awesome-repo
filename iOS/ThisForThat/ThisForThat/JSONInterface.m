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

+ (NSMutableArray *)offers
{
    static NSMutableArray *offersList = nil;
    
    if(offersList == nil)
    {
        offersList = [self initFromJSON:@"offers" ];
    }
    
    return offersList;
}

+ (NSMutableArray *)listings
{
    static NSMutableArray *listingsList = nil;
    
    if(listingsList == nil)
    {
        listingsList = [self initFromJSON:@"listings" ];
    }
    
    return listingsList;
}

+ (NSMutableArray *)users
{
    static NSMutableArray *usersList = nil;
    
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
        ListingData *data = [[ListingData alloc] initWithData:title description:description];
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


@end
