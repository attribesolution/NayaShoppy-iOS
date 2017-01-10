
//
//  AllProductModelview.m
//  nayashoppy
//
//  Created by Amerald on 10/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import "AllProductModelview.h"
#import "ApiParsing.h"

NSMutableArray *allproductimg,*allproducts,*popularproductimg,*popularproducts;
 int i;

@implementation AllProductModelview


+(void) ApiData: (NSString *)catId andBranch:(NSString*)branchId andPage:(NSNumber *)page andtag:(int)tag Aproduct:(NSArray *)allproduct Pproduct:(NSArray *)pproduct Aproductimg:(NSArray *)APimg Pproductimg:(NSArray *)PPimg ViewCon:(NSString*) vc
{
    
    allproducts=[allproduct copy];
    allproductimg=[APimg copy];
    popularproducts=[pproduct copy];
    popularproductimg=[PPimg copy];
    
    if([vc isEqualToString:@"MobileVc"])
    {
        if(tag==0 || allproducts.count==0)
        {
            [self getAllproduct:catId andBranch:branchId andPage:page];
        }
        if(tag==1 || popularproducts.count==0)
        {
            [self getPproduct:catId andBranch:branchId andPage:page];
        }
    }
    if([vc isEqualToString:@"ProductVc"])
    {
        if(tag==0)
        {
            [self getAllproduct:catId andBranch:branchId andPage:page];
        }
        if(tag==1)
        {
            [self getPproduct:catId andBranch:branchId andPage:page];
        }
    }
}
+(void) ReLoadArray:(NSArray *)response andvalue:(NSArray *)img
{
    if(allproducts.count==0 && i==1)
    {
        allproductimg=[img copy];
        allproducts=[response copy];
    }
    else if(popularproducts.count==0 && i==2)
    {
        popularproductimg=[img copy];
        popularproducts=[response copy];
    }
    else{
        
        NSArray *newArray,*newArrayimg;
        newArrayimg=[[NSArray alloc]init];
        newArray=[[NSArray alloc]init];
        if(i==1)
        {
            newArray=[allproductimg arrayByAddingObjectsFromArray:img];
            allproductimg=[newArray copy];
            newArrayimg=[allproducts arrayByAddingObjectsFromArray:response];
            allproducts=[newArrayimg copy];
        }
        else
        {
            newArray=[popularproductimg arrayByAddingObjectsFromArray:img];
            popularproductimg=[newArray copy];
            newArrayimg=[popularproducts arrayByAddingObjectsFromArray:response];
            popularproducts=[newArrayimg copy];
        }
    }
    
}
+(void) getAllproduct:(NSString *)catId andBranch:(NSString*)branchId andPage:(NSNumber *)page
{
    
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    [mainVC getAllProducts:^(NSArray *respone,NSArray *img) {
        i=1;
        [self ReLoadArray:respone andvalue:img];
        
        NSDictionary *allproduct=[[NSDictionary alloc]init];
        allproduct=@{
                     @"allproducts":allproducts,
                     @"allproductimg":allproductimg,
                     @"tag":[NSNumber numberWithInt:0],
                     };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCollectionView" object:nil userInfo:allproduct];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }
         catId:catId branchId:branchId page:page
     ];
}

+(void) getPproduct:(NSString *)catId andBranch:(NSString*)branchId andPage:(NSNumber *)page
{
       ApiParsing * mainVC = [[ApiParsing alloc] init];
       [mainVC getPopularProducts:^(NSArray *respone,NSArray *img) {
        i=2;
        [self ReLoadArray:respone andvalue:img];
        NSDictionary *Pproduct=[[NSDictionary alloc]init];
        Pproduct=@{
                   @"popularproducts":popularproducts,
                   @"popularproductimg":popularproductimg,
                   @"tag":[NSNumber numberWithInt:1],
                   };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCollectionView" object:nil userInfo:Pproduct];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }
      catId:catId branchId:branchId page:page
     ];

    
}
@end
