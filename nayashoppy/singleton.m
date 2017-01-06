//
//  singleton.m
//  nayashoppy
//
//  Created by Amerald on 20/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "singleton.h"

@implementation singleton
@synthesize topmenu,topmenuImg,CatBranchIDs,RecentlyViewed, MarkedFilters,UserReviews;

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

        UserReviews=[[NSMutableArray alloc]init];
        topmenu=[[NSMutableArray alloc]init];
        topmenuImg=[[NSMutableArray alloc]init];
        CatBranchIDs=[[NSMutableArray alloc]init];
        MarkedFilters=[[NSMutableDictionary alloc]init];
        RecentlyViewed=[[NSMutableArray alloc]init];

    }
    return self;
}

- (void)dealloc {
    
}

@end
