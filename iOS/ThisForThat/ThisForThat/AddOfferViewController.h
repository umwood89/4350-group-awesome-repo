//
//  AddOfferViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#import"ListingData.h"
#import "ASIHTTPRequest.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface AddOfferViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *addOfferTitleTextBox;
@property (strong, nonatomic) IBOutlet UITextField *addOfferListingTextBox;
@property (weak, nonatomic) IBOutlet UITextView *addOfferDescriptionTextBox;
@property (strong, nonatomic) IBOutlet UIImageView *imageBox;
@property (strong ,nonatomic) UIPopoverController *popover;
@property (strong ,nonatomic) ListingData *listing;

@property BOOL newMedia;

- (IBAction)cancelButton:(id)sender;
- (IBAction)createListing:(id)sender;

- (IBAction)choosePictureButton:(id)sender;
- (IBAction)takePictureButton:(id)sender;

@end
