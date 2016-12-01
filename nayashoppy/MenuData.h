//
//  MenuData.h
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuData : NSObject

@property (strong,nonatomic) NSMutableArray *topmenu;
@property (strong,nonatomic) NSMutableArray *topmenuImg;
@property (strong,nonatomic) NSMutableArray *newarrival;
@property (strong,nonatomic) NSMutableArray *newarrivalImg;
@property (strong,nonatomic) NSMutableArray *DealsOfTheDay;
@property (strong,nonatomic) NSMutableArray *DealsOfTheDayImg;
@property (strong,nonatomic) NSMutableArray *Child;
@property (strong,nonatomic) NSMutableArray *CatBranchIDs;
@property (strong,nonatomic) NSMutableArray *allproductimg;
@property (strong,nonatomic) NSMutableArray *allproducts;
@property (strong,nonatomic) NSMutableArray *popularproductimg;
@property (strong,nonatomic) NSMutableArray *popularproducts;
@property (strong,nonatomic) NSMutableArray *Similarproductimg;
@property (strong,nonatomic) NSMutableArray *Similarproducts;
@property (strong,nonatomic) NSMutableArray *ProductDetails;
@property (strong,nonatomic) NSMutableArray *RecentlyViewed;
@property (strong,nonatomic) NSMutableArray *GernalFeatures;
@property (strong,nonatomic) NSMutableDictionary *MarkedFilters;
@property (strong,nonatomic) NSString *CatId;
@property (strong,nonatomic) NSString *BranchId;
@property (strong,nonatomic) NSString *PCatId;
@property (strong,nonatomic) NSString *slug;
@property (strong,nonatomic) NSString *PPrice;
@property (strong,nonatomic) NSNumber *tabindex;
@property (strong,nonatomic) NSString *PType;
@property (strong,nonatomic) NSNumber *index;
@property (strong,nonatomic) NSNumber *Mobileindex;
+(MenuData *) Items;
@end
