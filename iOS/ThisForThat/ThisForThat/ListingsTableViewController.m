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

@interface ListingsTableViewController ()

@end

@implementation ListingsTableViewController

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
    self.title = @"Listings";
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)makeItHappen:(id)sender {
    //self.test = @"test";
    //self.testtextbox.text = self.test;
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/api/listings"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options :NSJSONReadingMutableContainers error: &e];
        
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            for(NSDictionary *item in jsonArray) {
                //NSLog(@"Item: %@", item);
                self.testtextbox.text = [NSString stringWithFormat:@"%@ %@", self.testtextbox.text, item.allValues];
            }
        }
        
        
        
      //  self.testtextbox.text = response;
        
    } else {
        self.test = @"error";
        self.testtextbox.text = self.test;
    }
    
    // Testing: addingn a couple of things to a listingsview
//    
    ListingData *list1 = [[ListingData alloc] initWithData:@"Yellow duck" description:@"duck description"];
    ListingData *list2 = [[ListingData alloc] initWithData:@"Yellow duck" description:@"duck description"];
//    
//    
//    
    self.listings = [NSMutableArray arrayWithObjects:list1,list2, nil];
    
    UINavigationController * navController = (UINavigationController *) self.parentViewController.presentedViewController;//    .rootViewController;
    
    
    ListingsTableViewController * listingController = [navController.viewControllers objectAtIndex:0];
    
    listingController.listings = self.listings;
    
//    
//    UINavigationController * navController = (UINavigationController *)  .window.rootViewController;
//    
//    ListingsTableViewController * listingController = [navController.viewControllers objectAtIndex:0];
//    //listingController.listings = self.listings;
    
    
 
}
@end
