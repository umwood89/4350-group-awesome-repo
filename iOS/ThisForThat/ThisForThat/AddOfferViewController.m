//
//  AddOfferViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-16.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "AddOfferViewController.h"



@implementation AddOfferViewController

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
    self.addOfferListingTextBox.text = self.listing.title;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)createListing:(id)sender {
    NSString *title = self.addOfferTitleTextBox.text;
    NSString *description = self.addOfferDescriptionTextBox.text;
    NSInteger user = 3;
    NSString *photo = @"photopath";
    
    NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/api/listings/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    
    //NSString *dataContent = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    
    NSString *dataContent = [NSString stringWithFormat:@"{\"title\": \"%@\", \"description\": \"%@\", \"user\": %d, \"photo\": \"%@\" }", title, description, user, photo];
    
    NSLog(@"dataContent: %@", dataContent);
    [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];
    NSString *response = [request responseString];
    NSLog(@"JSONAddListing response: %@", response);
    
    
}

- (IBAction)choosePictureButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        // Uncommenting the following line is bad.
        //[self presentViewController:imagePicker animated:YES completion:nil];
        self.popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        self.popover.delegate = self;
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [self.popover presentPopoverFromRect:CGRectMake(0.0, 0.0, 390.0, 425.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        //[popOverController inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES ];
        //[popOverController presentPopoverFromRect:(CGRect) inView:<#(UIView *)#> permittedArrowDirections:<#(UIPopoverArrowDirection)#> animated:YES]
        _newMedia = NO;
    }
}

- (IBAction)takePictureButton:(id)sender {
    NSLog(@"Taking picture");
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        _newMedia = YES;
    }
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        //_imageView.image = image;
        _imageBox.image = image;
        
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end


