//
//  OfferDetailsViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "OfferDetailsViewController.h"


@implementation OfferDetailsViewController

@synthesize TitleText;
@synthesize OfferImage;
@synthesize offerTitle;
@synthesize offerDescription;
@synthesize offerPhoto;
@synthesize offerCreateDate;
@synthesize DescriptionText;
@synthesize URLText;
@synthesize DateCreated;

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
    
    NSString *photoLocation = [NSString stringWithFormat:@"http://hackshack.ca/static/media/%@", offerPhoto];
    
    NSURL *url = [NSURL URLWithString:photoLocation];
    NSData *data;
    @try {
        data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        OfferImage.image = image;
        URLText.text = photoLocation;
        //    self.ListingImage.size = image.size;
    }
    @catch(NSException * e) {
        URLText.text = @"Photo not available.";
    }
    
    TitleText.text = offerTitle;
    DescriptionText.text = offerDescription;
    DateCreated.text = [offerCreateDate substringWithRange:NSMakeRange(0, 10)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
