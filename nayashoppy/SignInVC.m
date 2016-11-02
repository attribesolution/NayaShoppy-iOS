//
//  SignInVC.m
//  nayashoppy
//
//  Created by Amerald on 02/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SignInVC.h"

@interface SignInVC ()

@end

@implementation SignInVC
@synthesize SignInButton;
- (void)viewDidLoad {
    [super viewDidLoad];
   SignInButton.layer.cornerRadius = 15;
   SignInButton.clipsToBounds = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
