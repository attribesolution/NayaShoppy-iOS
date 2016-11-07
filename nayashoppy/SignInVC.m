//
//  SignInVC.m
//  nayashoppy
//
//  Created by Amerald on 02/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SignInVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SignInVC ()
{
    CGRect oldFrame;
    int i;
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

  
}

- (IBAction)SignInButton:(id)sender {
}

- (IBAction)Hint:(id)sender {
}

- (IBAction)GoogleSignIn:(id)sender {
    
}

- (IBAction)FacebookSignIn:(id)sender {
    
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

@end
