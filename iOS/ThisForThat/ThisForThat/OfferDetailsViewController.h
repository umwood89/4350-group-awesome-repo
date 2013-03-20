//
//  OfferDetailsViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfferData.h"

@interface OfferDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *TitleText;
@property (strong, nonatomic) IBOutlet UIImageView *OfferImage;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionText;
@property (strong, nonatomic) IBOutlet UILabel *DateCreated;
@property (strong, nonatomic) IBOutlet UILabel *ListedBy;
@property (nonatomic, strong) OfferData *offer;


- (IBAction)backButton:(id)sender;
@end
