//
//  OfferDetailsViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *TitleText;
@property (strong, nonatomic) IBOutlet UIImageView *OfferImage;
@property (strong, nonatomic) IBOutlet UITextView *DescriptionText;
@property (strong, nonatomic) IBOutlet UITextView *URLText;
@property (strong, nonatomic) IBOutlet UILabel *DateCreated;

@property (nonatomic, strong) NSString *offerTitle;
@property (nonatomic, strong) NSString *offerDescription;
@property (nonatomic, strong) NSString *offerPhoto;
@property (nonatomic, strong) NSString *offerCreateDate;
@property (nonatomic, strong) NSString *offerURL;
@end
