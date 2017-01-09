
//
//  SideTableData.m
//  nayashoppy
//
//  Created by Amerald on 09/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import "SideTableData.h"

@implementation SideTableData

+(NSArray *) UserInfo
{
    
    NSArray *UserInfo = @[
                          
                          @[ [UIImage imageNamed:@"Login"],@"Login/Register"],
                          @[ [UIImage imageNamed:@"My Order"],@"My Order"],
                          @[ [UIImage imageNamed:@"My Wallet"],@"My Wallet"],
                          @[ [UIImage imageNamed:@"My Wishlist"],@"Whish List"],
                          @[ [UIImage imageNamed:@"RateApp"],@"Rate the app"],
                          @[ @"About Us"],
                          
                          ];
    return UserInfo;
}

@end
