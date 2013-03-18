//
//  AddListingViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-14.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//
#pragma once
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "OfferData.h"
#import "ASIHTTPRequest.h"

@interface AddListingViewController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *addListingTitleTextBox;
@property (weak, nonatomic) IBOutlet UITextView *addListingDescriptionTextBox;
@property (strong, nonatomic) IBOutlet UIImageView *imageBox;
@property (strong ,nonatomic) UIPopoverController *popover;


@property BOOL newMedia;

- (IBAction)cancelButton:(id)sender;
- (IBAction)createListing:(id)sender;

- (IBAction)choosePictureButton:(id)sender;
- (IBAction)takePictureButton:(id)sender;


@end
