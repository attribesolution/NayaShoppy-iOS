//
//  FiltersValues.h
//  nayashoppy
//
//  Created by Amerald on 24/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Items.h"

@protocol FiltersValues
@end

@interface FiltersValues : JSONModel

@property (strong,nonatomic) NSDictionary <Optional> *facet_brand_id;
@property (strong,nonatomic) NSDictionary <Optional> *facet_category_id;
@property (strong,nonatomic) NSDictionary <Optional> *facet_store;
@property (strong,nonatomic) NSArray <Items,Optional> *filters;
@property (strong,nonatomic) NSArray <Optional> *facet_features;

@end
