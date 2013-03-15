//
//  OfferData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferData : NSObject

<<<<<<< HEAD
=======
@property (strong) NSString *title;
@property (strong) NSString *description;
@property (strong) NSURL *photo;
@property (assign) BOOL offer_accepted;
@property (strong) NSDate *date_created;
@property (strong) NSDate *date_completed;



- (id) initWithData:(NSString*)title description:(NSString*)description;

>>>>>>> Got our TableListView to show listing data! Finished some more of our static JSONInterface. Actual Progress!!!!
@end
