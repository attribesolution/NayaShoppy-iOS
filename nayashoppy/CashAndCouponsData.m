//
//  CashAndCouponsData.m
//  nayashoppy
//
//  Created by Amerald on 09/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import "CashAndCouponsData.h"

@implementation CashAndCouponsData

+(NSArray *) CashCoupons
{
    
    NSArray *CashCoupons = @[
                             @[ @"Mobile Recharge",[UIColor colorWithRed:230/255.0f green:141/255.0f blue:  25/255.0f alpha:1.0f]],
                             @[ @"Travel",[UIColor colorWithRed:92/255.0f green:181/255.0f blue:159/255.0f alpha:1.0f]],
                             @[ @"Food & Dining",[UIColor colorWithRed:189/255.0f green:102/255.0f blue:  217/255.0f alpha:1.0f]],
                             @[ @"Groceries",[UIColor colorWithRed:202/255.0f green:81/255.0f blue:  50/255.0f alpha:1.0f]],
                             @[ @"Movie Tickets",[UIColor colorWithRed:133/255.0f green:242/255.0f blue:  131/255.0f alpha:1.0f]],
                             
                             ];
    return CashCoupons;
}

@end
