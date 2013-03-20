//
//  OfferData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OfferData : NSObject

@property (strong) NSString *oid;
@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSString *photo;
@property (strong) NSString *offer_accepted;
@property (strong) NSString *date_created;
@property (strong) NSString *date_accepted;
@property (strong) NSString *listing;
@property (strong) NSString *user;

- (id) initWithData:(NSString *)oid title:(NSString*)title description:(NSString*)description photo:(NSString *)photo offer_accepted:(NSString *)offer_accepted date_created:(NSString *)date_created date_accepted:(NSString *)date_accepted listing:(NSString *)listing;

- (id)initWithData:(NSString*)title description:(NSString *)description;

- (id)initWithData:(NSString*)title description:(NSString *)description user:(NSString *)user listing:(NSString *)listing;



@end
