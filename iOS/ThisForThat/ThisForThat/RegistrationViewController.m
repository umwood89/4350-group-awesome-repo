//
//  RegistrationViewController.m
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-19.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import "RegistrationViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "ASIHTTPRequest.h"
#import "UserData.h"
#import "JSONInterface.h"


@implementation RegistrationViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerButton:(id)sender {
    self.registrationStatus.text = @"Registering..";
    
    if([self.password.text isEqualToString:self.verifyPassword.text]) {
        if(self.userName.text.length < 1 || self.firstName.text.length < 1 || self.lastName.text.length <1 || self.emailAddress.text.length <1 || self.password.text.length < 1 || self.verifyPassword.text.length < 1)
        {
            self.registrationStatus.text = @"Please fill out all fields";
        }
        else if (![self NSStringIsValidEmail:self.emailAddress.text]) {
            self.registrationStatus.text = @"Please enter a valid email address";
        }
        else {
            NSURL *url = [NSURL URLWithString:@"http://hackshack.ca/api/register/"];
            NSMutableDictionary *registrationData  = [[NSMutableDictionary alloc]init];
            
            [registrationData setObject:self.userName.text forKey:@"username"];
            [registrationData setObject:self.firstName.text forKey:@"firstname"];
            [registrationData setObject:self.lastName.text forKey:@"lastname"];
            [registrationData setObject:self.emailAddress.text forKey:@"email"];
            [registrationData setObject:self.password.text forKey:@"password"];
            
            NSError *error;
            NSData *jsondata = [NSJSONSerialization dataWithJSONObject:registrationData options:NSJSONWritingPrettyPrinted error:&error];
            NSString *dataContent = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
            
            NSLog(@"Registration post data: %@", dataContent);
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request addRequestHeader:@"Accept" value:@"application/json"];
            [request addRequestHeader:@"Content-Type" value:@"application/json"];
            
            [request appendPostData:[dataContent dataUsingEncoding:NSUTF8StringEncoding]];
            [request setRequestMethod:@"POST"];
            [request startSynchronous];
            
            NSString *response = [request responseString];
            NSLog(@"Registration response: %@", response);
            
            if([response isEqualToString:@"Username already in use"]) {
                self.registrationStatus.text = @"Username is already in use";
            }
            
            else {
                NSString *successMessage = [response substringToIndex:7];
                NSLog(@"successMessage: %@", successMessage);
                if([successMessage isEqualToString:@"success"]) {
                    self.registrationStatus.text = @"Registration Successful";
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Successful"
                                                                    message:@"Thank you for registering! You can now login using your username and password."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                    int userid = [[response substringFromIndex:7] intValue];
                    NSLog(@"id: %d", userid);
                    //alert release];
                    UserData *newuser = [[UserData alloc] initWithData:userid username:self.userName.text email:self.emailAddress.text];
                    [JSONInterface addUser:newuser];
                    
                    // Great success
                    [self.navigationController popViewControllerAnimated:NO];
                }
            }
        }
        
    }
    else {
        self.registrationStatus.text = @"Passwords do not match";
    }
    
    
}

- (IBAction)cancelButton:(id)sender {
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


-(NSString*) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH]={0};
    CC_SHA1(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}



@end
