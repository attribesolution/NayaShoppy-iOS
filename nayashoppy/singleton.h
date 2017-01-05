//
//  singleton.h
//  nayashoppy
//
//  Created by Amerald on 20/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Categories.h"

@interface singleton : NSObject

@property (strong,nonatomic) NSMutableArray *topmenu;
@property (strong,nonatomic) NSMutableArray *topmenuImg;
@property (strong,nonatomic) NSMutableArray *CatBranchIDs;
@property (strong,nonatomic) NSMutableArray *UserReviews;
@property (strong,nonatomic) NSMutableArray *RecentlyViewed;
@property (strong,nonatomic) NSMutableDictionary *MarkedFilters;
@property (strong,nonatomic) NSString *CatId;
@property (strong,nonatomic) NSString *BranchId;
@property (strong,nonatomic) NSString *PCatId;
@property (strong,nonatomic) NSString *slug;
@property (strong,nonatomic) NSString *PPrice;
@property (strong,nonatomic) NSNumber *page;

+ (id)sharedManager;

@end
