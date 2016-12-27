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
#import "UserReviews.h"

@interface SignInVC ()
{
    CGRect oldFrame;
    int i;
    NSString *userName;
    NSURL *url;
}
@end

@implementation SignInVC
@synthesize SignIn;

- (void)viewDidLoad {
    
   [super viewDidLoad];
    i=0;
   oldFrame.origin.y= self.view.frame.origin.y;
   oldFrame.size.height= self.view.frame.size.height;
   self.navigationItem.title =@"SIGN UP";
   self.navigationController.navigationBar.backgroundColor=[UIColor clearColor];
   SignIn.layer.cornerRadius = 15;
   SignIn.clipsToBounds = YES;
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    [GIDSignIn sharedInstance].uiDelegate = self;
    if ([FBSDKAccessToken currentAccessToken]) {
    }
}

- (IBAction)SignInButton:(id)sender {
  
}

- (IBAction)Hint:(id)sender {
}

- (IBAction)GoogleSignIn:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
    
}

- (IBAction)FacebookSignIn:(id)sender {

    singleton *obj=[singleton sharedManager];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                           initWithGraphPath:@"me"
                                           parameters:@{@"fields": @"name"}
                                           HTTPMethod:@"GET"];
             [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                   id results,
                                                   NSError *error) {
                 NSLog(@"%@",results);
                 userName=[results objectForKey:@"name"];
            
             }];
             FBSDKGraphRequest *requestpic = [[FBSDKGraphRequest alloc]
                                              initWithGraphPath:[NSString stringWithFormat:@"me/picture?type=large&redirect=false"]
                                              parameters:nil
                                              HTTPMethod:@"GET"];
             [requestpic startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                      id resultpic,
                                                      NSError *error) {
                 NSLog(@"%@",resultpic);
                 url = [NSURL URLWithString:[[resultpic objectForKey:@"data" ] objectForKey:@"url"]];
                 UserReviews *robj=[[UserReviews alloc]initWithName:userName andUrl:url];
                 [obj.UserReviews addObject:robj];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"SignIn" object:nil];
             }];
         }
     }];
    
    

}

- (IBAction)SignUp:(id)sender {
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.EmailField)
        [self.PasswordField becomeFirstResponder];
    
    else
        [textField resignFirstResponder];
    
    return YES;
}
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==self.EmailField && i==0)
    {
    self.EmailField.text=@" ";
        i++;
    }
   if(textField==self.PasswordField && i==0)
   {
        self.PasswordField.text=@" ";
       i++;
   }

       return YES;
}
#pragma mark - Keyboard Methods

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.15 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y -= 30;
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.15 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = oldFrame.origin.y;
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma google sign in

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}@end
