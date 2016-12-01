//
//  Filters.h
//  nayashoppy
//
//  Created by Amerald on 24/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FiltersValues.h"

@interface Filters : JSONModel

@property (strong,nonatomic) NSNumber *total;
@property (strong,nonatomic) NSNumber *took;
@property (strong,nonatomic) NSDictionary *items;
@property (strong,nonatomic) NSDictionary <FiltersValues> *facets;

@end
