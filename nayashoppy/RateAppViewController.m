//
//  RateAppViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "RateAppViewController.h"

@interface RateAppViewController ()

@end

@implementation RateAppViewController
@synthesize CancleButton,SubmitButton,Rating;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ButtonsStyling];
    [self nav];
    }

-(void) ButtonsStyling
{
    CancleButton.layer.cornerRadius = 5;
    CancleButton.clipsToBounds = YES;
    SubmitButton.layer.cornerRadius = 5;
    SubmitButton.clipsToBounds = YES;
    self.SubmitButton.backgroundColor=[[GlobalVariables class]greenColor];
    [Rating setFont:[UIFont fontWithName:@"fontello" size:30]];
    [Rating setText:[NSString stringWithUTF8String:"ue801"]];
 
}


-(void) nav
{
    
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"Rate the app" andImg:@"Logo" andy:logoY] ;
}

@end
