
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
                                       @[ @"apple",[UIColor colorWithRed:124/255.0f green:175/255.0f blue:65/255.0f alpha:1.0f]],
                                       @[ @"cup",[UIColor redColor]],
                                       @[ @"cake",[UIColor purpleColor]],
                                       @[ @"tea",[UIColor blueColor]],
                                       @[ @"tea",[UIColor orangeColor]],
                                       
                                       ];
    return CashCoupons;
}
@end
