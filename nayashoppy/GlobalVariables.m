
//
//  GlobalVariables.m
//  nayashoppy
//
//  Created by Amerald on 07/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "GlobalVariables.h"

UIImage *productImg=nil;
NSMutableArray *categories=nil,*myProducts=nil,*myProductsImg=nil;
NSUserDefaults *defaults;

@implementation GlobalVariables

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


+(void) AddWhishList:(NSString *)name :(NSString *)price :(NSString *) image :(UIView *) view
{
    BOOL find;
    find=NO;
    

    find=[self IsFound:name];
    if(!find)
    {
        
        defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ProductsImg,*Products,*ProductDetail;
        
        ProductsImg =[[NSMutableArray alloc] init];
        Products =[[NSMutableArray alloc] init];
        ProductDetail =[[NSMutableArray alloc] init];
        
        [ProductDetail addObject:name];
        [ProductDetail addObject:price];
        [Products addObject:ProductDetail];
        [ProductsImg addObject:image];
    
        NSObject *myobj=[defaults objectForKey:@"Product"];
        NSObject *myImgobj=[defaults objectForKey:@"ProductImg"];
        if(myImgobj == nil){
            
            myProductsImg =[[NSMutableArray alloc] init];
            [myProductsImg  addObject:ProductsImg];
            [defaults setObject:myProductsImg  forKey:@"ProductImg"];
        }
        
        else
        {
            myProductsImg  = [[defaults objectForKey:@"ProductImg"]mutableCopy];
            [myProductsImg   addObject:ProductsImg];
            [defaults setObject:myProductsImg forKey:@"ProductImg"];
        }
        
        if(myobj == nil){
            
            myProducts =[[NSMutableArray alloc] init];
            [myProducts addObject:Products];
            [defaults setObject:myProducts forKey:@"Product"];
        }
        
        else
        {
            myProducts = [[defaults objectForKey:@"Product"]mutableCopy];
            [myProducts  addObject:Products];
            [defaults setObject:myProducts  forKey:@"Product"];
        }
        
        [view makeToast:@"Item Added."];
        [defaults synchronize];
       }
    else
     {
         [view makeToast:@"Item Already Exist."];

     }
}

+(BOOL) IsFound:(NSString*)name
{
    for (int d=0; d<myProducts.count; d++) {
        
        NSString * Name=[[[myProducts objectAtIndex:d]objectAtIndex:0]objectAtIndex:0];
        if ([name isEqualToString:Name]) {
            
            return  YES;
        }
    }
    return NO;

}

@end
