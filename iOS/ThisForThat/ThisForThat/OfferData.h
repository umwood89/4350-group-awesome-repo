//
//  OfferData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OfferData : NSObject
@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSString *photo;
@property (assign) BOOL offer_accepted;
@property (strong) NSString *date_created;
@property (strong) NSString *date_accepted;

- (id) initWithData:(NSString*)title description:(NSString*)description photo:(NSString *)photo offer_accepted:(BOOL)offer_accepted date_created:(NSString *)date_created date_accepted:(NSString *)date_completed;

- (id)initWithData:(NSString*)title description:(NSString *)description;



@end
