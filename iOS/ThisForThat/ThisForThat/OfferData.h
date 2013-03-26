//
//  OfferData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OfferData : NSObject

@property int oid;
@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSString *photo;
@property (strong) NSString *offer_accepted;
@property (strong) NSString *date_created;
@property (strong) NSString *date_accepted;
@property int listing;
@property int user;

- (id) initWithData:(int)oid title:(NSString*)title description:(NSString*)description photo:(NSString *)photo offer_accepted:(NSString *)offer_accepted date_created:(NSString *)date_created date_accepted:(NSString *)date_accepted listing:(int)listing user:(int)user;

- (id)initWithData:(NSString*)title description:(NSString *)description;

- (id)initWithData:(NSString*)title description:(NSString *)description user:(int)user listing:(int)listing;



@end
