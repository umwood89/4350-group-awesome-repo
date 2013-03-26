//
//  ListingsTableViewController.m
//  ThisForThat
//
//  Created by Kyle Shewchuk on 2013-03-10.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "ListingsTableViewController.h"
#import "ASIHTTPRequest.h"
#import "ListingData.h"  // RS: our listing model object
#import "JSONInterface.h"
#import "ListingDetailsViewController.h"


@implementation ListingsTableViewController

@synthesize addListing;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Listings";
    
    if([[JSONInterface user_logged_in] isEmpty] == TRUE)
        addListing.enabled = NO;
    else
        addListing.enabled = YES;  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return 0;
    // RS: return number of sections from our array holding our super data
    return JSONInterface.listings.count;
}

// RS: Modified below section to load up listingsdata
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ListingTableCell"];
    ListingData *listing = [JSONInterface.listings objectAtIndex:indexPath.row];
      
    
    cell.textLabel.text = listing.title;
    cell.detailTextLabel.text = listing.description;
    //cell.imageView.image = bug.thumbImage;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
   //  <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    
    //ListingDetailsViewController *detailsView = [[ListingDetailsViewController alloc] initWithNibName:@"ListingDetailViewController" bundle:nil];

    //[self.navigationController pushViewController:detailsView animated:YES];

    
}

- (IBAction)logoutButton:(id)sender {
    
    // Pop this view. Head back to login screen.
    [self.navigationController popViewControllerAnimated:YES];
    [JSONInterface  changeLoggedInUser:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showListingDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ListingDetailsViewController *destViewController = segue.destinationViewController;
        ListingData *listing = [JSONInterface.listings objectAtIndex:indexPath.row];
        
        destViewController.listing = listing;
    }
}


@end
