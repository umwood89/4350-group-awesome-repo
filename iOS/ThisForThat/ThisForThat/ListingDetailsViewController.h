//
//  ListingDetailsViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *TitleText;
@property (strong, nonatomic) IBOutlet UIImageView *ListingImage;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionText;

@property (nonatomic, strong) NSString *listingTitle;
@property (nonatomic, strong) NSString *listingDescription;
@property (nonatomic, strong) NSString *listingPhoto;
@property (nonatomic, strong) NSString *listingCreateDate;


- (IBAction)backButton:(id)sender;

@end
