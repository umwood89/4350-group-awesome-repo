//
//  ListingDetailsViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListingData.h"

@interface ListingDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *TitleText;
@property (strong, nonatomic) IBOutlet UIImageView *ListingImage;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionText;
@property (strong, nonatomic) IBOutlet UILabel *DateCreated;
@property (strong, nonatomic) IBOutlet UILabel *ListedBy;
@property (weak, nonatomic) IBOutlet UIButton *makeOffer;


@property (nonatomic, strong) ListingData *listing;


- (IBAction)backButton:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
