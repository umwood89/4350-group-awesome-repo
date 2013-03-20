//
//  ListingDetailsViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ListingDetailsViewController.h"
#import "AddOfferViewController.h"
#import "JSONInterface.h"
#import <UIKit/UIImageView.h>
#import <UIKit/UIImage.h>



@implementation ListingDetailsViewController

@synthesize TitleText;
@synthesize ListingImage;
@synthesize DescriptionText;
@synthesize DateCreated;
@synthesize ListedBy;
@synthesize listing;
@synthesize makeOffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if([[JSONInterface user_logged_in] isEmpty] == TRUE)
        makeOffer.hidden = YES;
    else
        makeOffer.hidden = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *photoLocation = [NSString stringWithFormat:@"http://hackshack.ca/static/media/%@", listing.photo];

    NSURL *url = [NSURL URLWithString:photoLocation];
    NSData *data;
    @try {
        data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        ListingImage.image = image;
        //    self.ListingImage.size = image.size;
    }
    @catch(NSException * e) {
        NSLog(@"%@",e);
    }
    
    TitleText.text = listing.title;
    DescriptionText.text = listing.description;
    DateCreated.text = [listing.date_created substringWithRange:NSMakeRange(0, 10)];
    
    UserData *userPosted = [JSONInterface getUserByID:listing.user.integerValue ];
    
    ListedBy.text = userPosted.username;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addOfferFromListing"]) {
        AddOfferViewController *destViewController = segue.destinationViewController;
        destViewController.listing = listing;
    }
}
@end
