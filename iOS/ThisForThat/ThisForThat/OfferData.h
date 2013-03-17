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
@property (strong) NSDate *date_created;
@property (strong) NSDate *date_accepted;

- (id) initWithData:(NSString*)title description:(NSString*)description photo:(NSURL *)photo offer_accepted:(BOOL)offer_accepted date_created:(NSDate *)date_created date_completed:(NSDate *)date_completed;

- (id)initWithData:(NSString*)title description:(NSString *)description;



@end
