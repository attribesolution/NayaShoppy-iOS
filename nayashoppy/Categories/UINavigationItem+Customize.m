//
//  UINavigationItem+Customize.m
//  nayashoppy
//
//  Created by kashif Saeed on 03/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "UINavigationItem+Customize.h"

@implementation UINavigationItem (Customize)

-(void)setLeftBarItemsForProductView:(NSArray *)items{
    
    
}
-(void)setRightBarItemsForProductView:(NSArray *)items{
    
}
-(void) titleView:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y
{
    self.titleView = [self createViewWithtitle:title1 andImg:img andy:y];;
}
-(UIView*)createViewWithtitle:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y{
    
    UIImage *logo=[UIImage imageNamed:img];
    UIImageView *img1=[[UIImageView alloc] initWithFrame:CGRectMake(0,-5 , logo.size.width, logo.size.height)];
    img1.image=logo;
    UIView *titleViewWithImageAndLogo=[[UIView alloc]initWithFrame:CGRectMake(100,y- logo.size.height/2.0f , 180, logo.size.height)];
    [titleViewWithImageAndLogo addSubview:img1];
    UILabel *title= [[UILabel alloc] initWithFrame:CGRectMake(logo.size.width+10, -2, 180, 35)];
    title.text=title1;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont boldSystemFontOfSize:17];
    [titleViewWithImageAndLogo addSubview:title];
    titleViewWithImageAndLogo.backgroundColor =[UIColor clearColor];
    
    return titleViewWithImageAndLogo;
}
@end
