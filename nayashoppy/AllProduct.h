//
//  AllProduct.h
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ProductDetails.h"

@interface AllProduct : JSONModel
@property (strong,nonatomic) NSArray <ProductDetails> *data;
@property (strong,nonatomic) NSDictionary *meta;
@property (strong,nonatomic) NSDictionary <Optional> *pagination;
@end
