//
//  MenuData.m
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "MenuData.h"

static MenuData *data = nil;

@implementation MenuData
@synthesize topmenu,topmenuImg,newarrival,newarrivalImg,DealsOfTheDayImg,DealsOfTheDay,Child,CatBranchIDs,CatId,BranchId,allproductimg,allproducts,index,Similarproductimg,PPrice,ProductDetails,PCatId,Similarproducts,slug,popularproducts,popularproductimg,PType,GernalFeatures,tabindex,RecentlyViewed, Mobileindex,MarkedFilters,page;

+(MenuData *) Items
{
    
    if(!data)
    {
        data=[[super allocWithZone:nil]init];
        
           }
    return data;
    
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return data;
}

-(id) init
{
    self=[super init];
    if(self)
    {
        CatId=@" ";
        BranchId=@" ";
        PPrice=@" ";
        PCatId=@" ";
        slug=@" ";
        PType=@" ";
        Mobileindex=0;
        page=0;
        tabindex=0;
        index=0;
        topmenu=[[NSMutableArray alloc]init];
        topmenuImg=[[NSMutableArray alloc]init];
        newarrival=[[NSMutableArray alloc]init];
        newarrivalImg=[[NSMutableArray alloc]init];
        DealsOfTheDay=[[NSMutableArray alloc]init];
        DealsOfTheDayImg=[[NSMutableArray alloc]init];
        Child=[[NSMutableArray alloc]init];
        CatBranchIDs=[[NSMutableArray alloc]init];
        allproducts=[[NSMutableArray alloc]init];
        allproductimg=[[NSMutableArray alloc]init];
        Similarproducts=[[NSMutableArray alloc]init];
        Similarproductimg=[[NSMutableArray alloc]init];
        ProductDetails=[[NSMutableArray alloc]init];
        popularproductimg=[[NSMutableArray alloc]init];
        popularproducts=[[NSMutableArray alloc]init];
        GernalFeatures=[[NSMutableArray alloc]init];
        MarkedFilters=[[NSMutableDictionary alloc]init];
        RecentlyViewed=[[NSMutableArray alloc]init];
    }
    return self;
}
@end
