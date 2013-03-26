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
+ (UserData *)user_logged_in;

+ (NSMutableArray *)initFromJSON:(NSString *)url;
+ (void) addDataToList:(NSString *)type list:(NSMutableArray *) list item:(NSDictionary *) item;

+ (ListingData *) getListingByID:(int)id;
+ (OfferData *) getOfferByID:(int)id;
+ (UserData *) getUserByID:(int)id;
+ (UserData *)getUserByUsername:(NSString *)username;

+ (NSMutableArray *)getOffersForListing:(int)listing_id;

+ (NSMutableArray *)getOffersForLoggedInUser;
+ (NSMutableArray *)getListingsForLoggedInUser;

+ (void) changeLoggedInUser:(UserData *)newUser;

+ (ListingData *) addListing:(ListingData *)toAdd imageData:(NSData *)imageData;
+ (OfferData *) addOffer:(OfferData *)toAdd imageData:(NSData *)imageData;
+ (UserData *) addUser:(UserData *)toAdd;

+ (OfferData *) updateOffer:(OfferData *)toAdd imageData:(NSData *)imageData;
+ (ListingData *) updateListing:(ListingData *)toAdd imageData:(NSData *)imageData;

+ (void) cancelOffer:(OfferData *)toDelete;
+ (void) deleteListing:(ListingData *)toDelete;

+ (void) findAndDeleteAssociatedOffers:(int)listing_id;

+ (NSDictionary *) getDictionaryFromJSON:(NSString *)json;

+ (NSString *) rightNowInString;

@end
