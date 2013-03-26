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
@synthesize acceptOffer;
@synthesize cancelOffer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    ListingData *listing = [JSONInterface getListingByID:offer.listing];
    
    if([JSONInterface user_logged_in].uid == offer.user)
        cancelOffer.hidden = NO;
    else
        cancelOffer.hidden = YES;
    
    if([JSONInterface user_logged_in].uid == listing.user)
        acceptOffer.hidden = NO;
    else
        acceptOffer.hidden = YES;
    
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
    
    UserData *userPosted = [JSONInterface getUserByID:offer.user ];
    
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
    
    
    
    if([segue.identifier isEqualToString:@"showListingDetails2"])
    {
        ListingDetailsViewController *destViewController = segue.destinationViewController;
        ListingData *listing = [JSONInterface getListingByID:offer.listing];
    
        destViewController.listing = listing;
    }
    if([segue.identifier isEqualToString:@"acceptOffer"])
    {
        ListingDetailsViewController *destViewController = segue.destinationViewController;
        ListingData *listing = [JSONInterface getListingByID:offer.listing];
        
        destViewController.listing = listing;
        listing.trade_completed = @"1";
        listing.date_completed = [JSONInterface rightNowInString];
        offer.offer_accepted = @"1";
        offer.date_accepted = [JSONInterface rightNowInString];
        
        NSString *photoLocation = [NSString stringWithFormat:@"http://hackshack.ca/static/media/%@", offer.photo];
        NSURL *url = [NSURL URLWithString:photoLocation];
        NSData *data;
        @try {
            data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            OfferImage.image = image;
            [JSONInterface updateOffer:offer imageData:data];
        }
        @catch(NSException * e) {
            NSLog(@"%@",e);
        } 
    }
    else if([segue.identifier isEqualToString:@"cancelOffer"])
    {
        [JSONInterface cancelOffer:offer];
    }
}

@end
