//
//  SignInVC.h
//  nayashoppy
//
//  Created by Amerald on 02/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInVC : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *SignIn;
@property (strong, nonatomic) IBOutlet UITextField *EmailField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordField;

- (IBAction)SignInButton:(id)sender;
- (IBAction)Hint:(id)sender;
- (IBAction)GoogleSignIn:(id)sender;
- (IBAction)FacebookSignIn:(id)sender;
- (IBAction)SignUp:(id)sender;



@end
