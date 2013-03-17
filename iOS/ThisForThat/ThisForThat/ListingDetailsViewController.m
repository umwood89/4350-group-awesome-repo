//
//  ListingDetailsViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ListingDetailsViewController.h"
#import <UIKit/UIImageView.h>
#import <UIKit/UIImage.h>

@interface ListingDetailsViewController ()

@end

@implementation ListingDetailsViewController

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
   //NSURL *url = [NSURL URLWithString:@"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRajjO8BR8VeGKBa27nN8RpJtBRU4SySTAry15Acf8x6Z4q94qx"];
    //NSData *data = [NSData dataWithContentsOfURL:url];
    // self.ListingImage = [[UIImage alloc] initWithData:data];
    
    //CGSize size = img.size;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
