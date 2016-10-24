//
//  NewArrivals.h
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Products.h"

@interface NewArrivals : JSONModel

@property (strong,nonatomic) NSArray <Products> *data;
@property (strong,nonatomic) NSDictionary *meta;

@end
