
//
//  singleton.m
//  nayashoppy
//
//  Created by Amerald on 20/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "singleton.h"

@implementation singleton
@synthesize topmenu,topmenuImg,newarrival,newarrivalImg,Child,CatBranchIDs,CatId,BranchId,PPrice,ProductDetails,PCatId,slug,GernalFeatures,tabindex,RecentlyViewed, MarkedFilters,page,UserReviews;

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

        CatId=@" ";
        BranchId=@" ";
        PPrice=@" ";
        PCatId=@" ";
        slug=@" ";
        page=0;
        tabindex=0;
        UserReviews=[[NSMutableArray alloc]init];
        topmenu=[[NSMutableArray alloc]init];
        topmenuImg=[[NSMutableArray alloc]init];
        newarrival=[[NSMutableArray alloc]init];
        newarrivalImg=[[NSMutableArray alloc]init];
        Child=[[NSMutableArray alloc]init];
        CatBranchIDs=[[NSMutableArray alloc]init];
        ProductDetails=[[NSMutableArray alloc]init];
        GernalFeatures=[[NSMutableArray alloc]init];
        MarkedFilters=[[NSMutableDictionary alloc]init];
        RecentlyViewed=[[NSMutableArray alloc]init];

    }
    return self;
}

- (void)dealloc {
    
}

@end
