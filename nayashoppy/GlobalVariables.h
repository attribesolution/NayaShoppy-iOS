//
//  GlobalVariables.h
//  nayashoppy
//
//  Created by Amerald on 07/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"
#import "CategoriesCell.h"
#import "Categories.h"
#import "AFHTTPSessionManager.h"
#import "ApiParsing.h"
#import "SWRevealViewController.h"
#import "UIView+Toast.h"

static NSString *topmenuNotification = @"refreshView";
static NSString *LoadingText = @"Loading Data...";
extern NSMutableArray *categories,*myProducts,*myProductsImg;
extern  NSUserDefaults *defaults;
extern UIImage *productImg;

@interface GlobalVariables : NSObject
+(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y;
+(UIView *) titleView:(NSString *) title1 andImg:(NSString *) img;
+(void) AddWhishList:(NSString *)name :(NSString *)price :(NSString *) image :(UIView *) view;
+(NSArray *) CashCoupons;
+(NSArray *) UserInfo;
+(UIColor*)themeColor;
+(UIColor*) greenColor;

@end
