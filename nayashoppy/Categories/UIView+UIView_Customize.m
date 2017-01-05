

//
//  UIView+UIView_Customize.m
//  nayashoppy
//
//  Created by Amerald on 05/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import "UIView+UIView_Customize.h"

@implementation UIView (UIView_Customize)

-(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y
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

-(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img
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

@end
