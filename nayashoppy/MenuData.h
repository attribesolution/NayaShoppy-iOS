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
@property (strong,nonatomic) NSMutableArray *Similarproductimg;
@property (strong,nonatomic) NSMutableArray *Similarproducts;
@property (strong,nonatomic) NSString *CatId;
@property (strong,nonatomic) NSString *BranchId;
@property (strong,nonatomic) NSString *PCatId;
@property (strong,nonatomic) NSString *slug;
@property (strong,nonatomic) NSString *PPrice;
@property (strong,nonatomic) NSNumber *index;
+(MenuData *) Items;
@end
