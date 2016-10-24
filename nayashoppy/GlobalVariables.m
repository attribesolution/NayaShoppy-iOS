
//
//  GlobalVariables.m
//  nayashoppy
//
//  Created by Amerald on 07/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "GlobalVariables.h"

NSMutableArray *categories=nil;

@implementation GlobalVariables

+(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y
{
    UIImage *logo=[UIImage imageNamed:img];
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(0,-5 , logo.size.width, logo.size.height)];
    img1.image=logo;
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(100,y- logo.size.height/2.0f , 180, logo.size.height)];
    [titleView addSubview:img1];
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(logo.size.width+10, -2, 180, 35)];
    title.text=title1;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:17];
    [titleView addSubview:title];
    titleView.backgroundColor =[UIColor clearColor];
    return titleView;
}

+(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img
{
    UIImage *logo=[UIImage imageNamed:img];
    UIImageView *img1=[[UIImageView alloc] initWithImage:logo];
    UIView *titleView=[[UIView alloc]init];
    [titleView addSubview:img1];
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(logo.size.width+5, -2, 180, 35)];
    title.text=title1;
    title.textColor = [UIColor darkGrayColor];
    title.font = [UIFont boldSystemFontOfSize:15];
    [titleView addSubview:title];
    titleView.backgroundColor =[UIColor clearColor];
    return titleView;
}
+(NSArray *) CashCoupons
{

    NSArray *CashCoupons = @[
                                       @[ @"Mobile Recharge",[UIColor colorWithRed:230/255.0f green:141/255.0f blue:  25/255.0f alpha:1.0f]],
                                       @[ @"Travel",[UIColor colorWithRed:92/255.0f green:181/255.0f blue:  159/255.0f alpha:1.0f]],
                                       @[ @"Food & Dining",[UIColor colorWithRed:189/255.0f green:102/255.0f blue:  217/255.0f alpha:1.0f]],
                                       @[ @"Groceries",[UIColor colorWithRed:202/255.0f green:81/255.0f blue:  50/255.0f alpha:1.0f]],
                                       @[ @"Movie Tickets",[UIColor colorWithRed:133/255.0f green:242/255.0f blue:  131/255.0f alpha:1.0f]],
                                       
                                       ];
    return CashCoupons;
}
+(NSArray *) UserInfo
{
    
    NSArray *UserInfo = @[
                             @[ [UIImage imageNamed:@"logo.png"],@"Login/Register"],
                             @[ [UIImage imageNamed:@"logo.png"],@"My Order"],
                             @[ [UIImage imageNamed:@"logo.png"],@"My Wallet"],
                             @[ [UIImage imageNamed:@"logo.png"],@"Whish List"],
                             @[ [UIImage imageNamed:@"logo.png"],@"Rate the app"],
                             @[ @"About Us"],
                                
                             
                             ];
    return UserInfo;
}
@end
