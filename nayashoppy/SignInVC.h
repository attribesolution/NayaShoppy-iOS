//
//  SignInVC.h
//  nayashoppy
//
//  Created by Amerald on 02/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "GlobalVariables.h"

@interface SignInVC : UIViewController<GIDSignInUIDelegate>
@property (strong, nonatomic) IBOutlet UIButton *SignIn;
@property (strong, nonatomic) IBOutlet UITextField *EmailField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordField;
@property (strong, nonatomic) IBOutlet UIImageView *LogoImg;

- (IBAction)SignInButton:(id)sender;
- (IBAction)Hint:(id)sender;
- (IBAction)GoogleSignIn:(id)sender;
- (IBAction)FacebookSignIn:(id)sender;
- (IBAction)SignUp:(id)sender;



@end
