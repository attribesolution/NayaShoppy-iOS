
//
//  singleton.m
//  nayashoppy
//
//  Created by Amerald on 20/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "singleton.h"

@implementation singleton
@synthesize someProperty,topmenu,topmenuImg,newarrival,newarrivalImg,DealsOfTheDayImg,DealsOfTheDay,Child,CatBranchIDs,CatId,BranchId,allproductimg,allproducts,index,Similarproductimg,PPrice,ProductDetails,PCatId,Similarproducts,slug,popularproducts,popularproductimg,PType,GernalFeatures,tabindex,RecentlyViewed, Mobileindex,MarkedFilters,page,UserReviews;

#pragma mark Singleton Methods

+ (id)sharedManager {
    
    static singleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
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
        UserReviews=[[NSMutableArray alloc]init];
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

- (void)dealloc {
    
}

@end
