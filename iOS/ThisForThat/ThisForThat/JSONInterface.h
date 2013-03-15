//
//  JSONInterface.h
//  ThisForThat
//
//  Created by  on 3/14/13.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONInterface : NSObject

+ (NSMutableArray *)offers;
+ (NSMutableArray *)listings;
+ (NSMutableArray *)users;

+ (NSMutableArray *)initFromJSON:(NSString *)url;
+ (void) addDataToList:(NSString *)type list:(NSMutableArray *) list item:(NSDictionary *) item;



@end