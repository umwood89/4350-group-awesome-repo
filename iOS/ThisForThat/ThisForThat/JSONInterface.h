//
//  JSONInterface.h
//  ThisForThat
//
//  Created by  on 3/14/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListingData.h"
#import "OfferData.h"
#import "UserData.h"
//#import "UserData.h"

@interface JSONInterface : NSObject

+ (NSMutableArray *)offers;
+ (NSMutableArray *)listings;
+ (NSMutableArray *)users;

+ (NSMutableArray *)initFromJSON:(NSString *)url;
+ (void) addDataToList:(NSString *)type list:(NSMutableArray *) list item:(NSDictionary *) item;

+ (ListingData *) getListingByID:(int)id;
+ (OfferData *) getOfferByID:(int)id;
+ (UserData *) getUserByID:(int)id;

+ (ListingData *) addListing:(ListingData *)toAdd;
+ (OfferData *) addOffer:(OfferData *)toAdd;
+ (UserData *) addUser:(UserData *)toAdd;

@end
