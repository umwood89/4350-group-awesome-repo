//
//  ListingData.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListingData : NSObject

@property (strong) NSString *title;
@property (strong) NSString *description;

-(id)initWithData:(NSString*)title description:(NSString*)description;

@end
