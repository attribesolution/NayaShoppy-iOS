
//
//  UserDefaults.m
//  nayashoppy
//
//  Created by Amerald on 09/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import "UserDefaults.h"

NSMutableArray *categories=nil,*myProducts=nil,*myProductsImg=nil;
NSUserDefaults *defaults;

@implementation UserDefaults

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
