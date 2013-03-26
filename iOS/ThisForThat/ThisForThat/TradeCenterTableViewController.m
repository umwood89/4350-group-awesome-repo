//
//  TradeCenterTableViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-25.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "TradeCenterTableViewController.h"
#import "OfferData.h"
#import "ListingData.h"
#import "JSONInterface.h"
#import "ASIHTTPRequest.h"
#import "OfferDetailsViewController.h"
#import "ListingDetailsViewController.h"

@implementation TradeCenterTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 1)
    {
        //return JSONInterface.offers.count;
        return [JSONInterface getOffersForLoggedInUser].count;
        
    }
    else if(section == 0)
    {
        //return JSONInterface.listings.count;
        return [JSONInterface getListingsForLoggedInUser].count;
    }
    
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.section == 1)
    {
       // Get offers for user that's logged in
        OfferData *offer = [[JSONInterface getOffersForLoggedInUser] objectAtIndex: indexPath.row];
        
        //OfferData *offer = [JSONInterface.offers objectAtIndex: indexPath.row];
                cell = [tableView dequeueReusableCellWithIdentifier:@"ListingTableCell"];
        cell.textLabel.text = offer.title;
        return cell;
        
    }
    else if(indexPath.section == 0)
    {
        //ListingData *listing = [JSONInterface.listings objectAtIndex:indexPath.row];
        ListingData *listing = [[JSONInterface getListingsForLoggedInUser] objectAtIndex: indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:@"OfferTableCell"];
        cell.textLabel.text = listing.title;
        return cell;
        
    }
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //cell.description = @"JERKFACE";
    // Configure the cell...
    
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return @"Your Listings";
    else if(section == 1)
        return @"Offers you've made on listings";
    return @"section";
}



- (IBAction)logoutButton:(id)sender {
    // Send server logout request
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/logout"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    
    // Tell API user is logged out
    [JSONInterface changeLoggedInUser:nil];
    
    // Pop this view. Head back to login screen.
    [self.navigationController popViewControllerAnimated:YES];
    [JSONInterface  changeLoggedInUser:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOfferDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        OfferDetailsViewController *destViewController = segue.destinationViewController;
        OfferData *offer = [[JSONInterface getOffersForLoggedInUser] objectAtIndex:indexPath.row];
        
        destViewController.offer = offer;
    }
    else if ([segue.identifier isEqualToString:@"showListingDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ListingDetailsViewController *destViewController = segue.destinationViewController;
        ListingData *listing = [[JSONInterface getListingsForLoggedInUser] objectAtIndex:indexPath.row];
        
        destViewController.listing = listing;
    }
}

@end
