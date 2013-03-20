//
//  OfferDetailsViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "OfferDetailsViewController.h"
#import "JSONInterface.h"
#import "ListingDetailsViewController.h"


@implementation OfferDetailsViewController

@synthesize TitleText;
@synthesize OfferImage;
@synthesize offer;
@synthesize DescriptionText;
@synthesize DateCreated;
@synthesize ListedBy;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *photoLocation = [NSString stringWithFormat:@"http://hackshack.ca/static/media/%@", offer.photo];
    
    NSURL *url = [NSURL URLWithString:photoLocation];
    NSData *data;
    @try {
        data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        OfferImage.image = image;
        //    self.ListingImage.size = image.size;
    }
    @catch(NSException * e) {
        NSLog(@"%@",e);
    }
    
    TitleText.text = offer.title;
    DescriptionText.text = offer.description;
    DateCreated.text = [offer.date_created substringWithRange:NSMakeRange(0, 10)];
    
    UserData *userPosted = [JSONInterface getUserByID:offer.user.integerValue ];
    
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
    if ([segue.identifier isEqualToString:@"showListingDetails2"]) {
        ListingDetailsViewController *destViewController = segue.destinationViewController;
        ListingData *listing = [JSONInterface getListingByID:offer.listing.integerValue];
        
        destViewController.listing = listing;
    }
}

@end
