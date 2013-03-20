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


@interface RegistrationViewController ()

@end

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