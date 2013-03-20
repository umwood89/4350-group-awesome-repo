//
//  RegistrationViewController.h
//  ThisForThat
//
//  Created by Richard Sipinski on 2013-03-19.
//  Copyright (c) 2013 Kyle Shewchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailAddress;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassword;

@property (weak, nonatomic) IBOutlet UILabel *registrationStatus;

- (IBAction)registerButton:(id)sender;
- (IBAction)registerButton2:(id)sender;

-(NSString*) sha256:(NSString *)clear;

@end
