//
//  Deals.h
//  nayashoppy
//
//  Created by Amerald on 26/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DealsOfDay.h"

@interface Deals : JSONModel

@property (strong,nonatomic) NSArray <DealsOfDay> *data;
@property (strong,nonatomic) NSDictionary *meta;

@end
