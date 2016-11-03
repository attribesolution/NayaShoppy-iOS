//
//  SignInVC.m
//  nayashoppy
//
//  Created by Amerald on 02/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SignInVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface SignInVC ()
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@end

@implementation SignInVC
@synthesize SignIn;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   SignIn.layer.cornerRadius = 15;
   SignIn.clipsToBounds = YES;
  
}

- (IBAction)SignInButton:(id)sender {
}

- (IBAction)Hint:(id)sender {
}

- (IBAction)GoogleSignIn:(id)sender {
    
}

- (IBAction)FacebookSignIn:(id)sender {
    
   FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error) {
            NSLog(@"Process error");
        } else if (result.isCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Logged in");
        }
        
        
    }];
    
}

- (IBAction)SignUp:(id)sender {
}
@end
