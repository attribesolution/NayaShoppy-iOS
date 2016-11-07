//
//  RateAppViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "RateAppViewController.h"

@interface RateAppViewController ()
{
    CGRect oldFrame;
}
@end

@implementation RateAppViewController
@synthesize CancleButton,SubmitButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    CancleButton.layer.cornerRadius = 5;
    CancleButton.clipsToBounds = YES;
    SubmitButton.layer.cornerRadius = 5;
    SubmitButton.clipsToBounds = YES;
    oldFrame.origin.y= self.view.frame.origin.y;
    oldFrame.size.height= self.view.frame.size.height;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"Rate the app" andImg:@"Logo" andy:logoY] ;
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
        CGRect newFrame = [self.view frame];
        newFrame.origin.y -= 40;
        [self.view setFrame:newFrame];
        
   
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
