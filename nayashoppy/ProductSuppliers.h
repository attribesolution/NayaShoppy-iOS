//
//  ProductSuppliers.h
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ProductSuppliers
@end

@interface ProductSuppliers : JSONModel
@property (strong,nonatomic) NSNumber *product_id;
@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSNumber *store_id;
@property (strong,nonatomic) NSNumber *price_status;
@property (strong,nonatomic) NSString *cod;
@property (strong,nonatomic) NSString *emi;
@property (strong,nonatomic) NSString *return_policy;
@property (strong,nonatomic) NSString *delivery;
@property (strong,nonatomic) NSString *shipping;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *unique_id;
@property (strong,nonatomic) NSString *discount;
@property (strong,nonatomic) NSString *original_price;
@property (strong,nonatomic) NSString *rating;
@property (strong,nonatomic) NSString *rating_user_count;
@property (strong,nonatomic) NSString *reviews;
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSString *product_status;
@property (strong,nonatomic) NSString *store_name;
@property (strong,nonatomic) NSString *meta_title;
@property (strong,nonatomic) NSString *meta_keyword;
@property (strong,nonatomic) NSString *meta_desc;
@property (strong,nonatomic) NSString *active;
@property (strong,nonatomic) NSString *created;
@end
