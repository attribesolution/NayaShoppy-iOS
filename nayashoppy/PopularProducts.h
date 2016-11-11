//
//  PopularProducts.h
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PProductDetails.h"

@interface PopularProducts : JSONModel
@property (strong,nonatomic) NSArray <PProductDetails> *data;
@property (strong,nonatomic) NSDictionary *meta;
@property (strong,nonatomic) NSDictionary *pagination;

@end
