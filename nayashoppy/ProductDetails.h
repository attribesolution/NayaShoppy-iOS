//
//  ProductDetails.h
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Images.h"
#import "ProductSuppliers.h"
#import "Features.h"

@protocol ProductDetails
@end

@interface ProductDetails : JSONModel
@property (strong,nonatomic) NSNumber *product_id;
@property (strong,nonatomic) NSNumber *categories_category_id;
@property (strong,nonatomic) NSNumber *brands_brand_id;
@property (strong,nonatomic) NSString *product_name;
@property (strong,nonatomic) NSString *slug ;
@property (strong,nonatomic) NSString <Optional> *image;
@property (strong,nonatomic) NSString *product_description;
@property (strong,nonatomic) NSString *model_number;
@property (strong,nonatomic) NSString *cod;
@property (strong,nonatomic) NSString *emi;
@property (strong,nonatomic) NSString *return_policy;
@property (strong,nonatomic) NSString <Optional> *delivery;
@property (strong,nonatomic) NSString *shipping;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString <Optional> *unique_id;
@property (strong,nonatomic) NSString *discount;
@property (strong,nonatomic) NSString *rating;
@property (strong,nonatomic) NSString *rating_user_count;
@property (strong,nonatomic) NSString *reviews;
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSString *product_status;
@property (strong,nonatomic) NSString *date_add;
@property (strong,nonatomic) NSString *date_update;
@property (strong,nonatomic) NSString *date_launch;
@property (strong,nonatomic) NSString *lowest_price;
@property (strong,nonatomic) NSString *original_price;
@property (strong,nonatomic) NSString *highest_price;
@property (strong,nonatomic) NSString *link_rewrite;
@property (strong,nonatomic) NSNumber *supplier_count;
@property (strong,nonatomic) NSNumber *store_name;
@property (strong,nonatomic) NSNumber *store_id;
@property (strong,nonatomic) NSString *meta_title;
@property (strong,nonatomic) NSString *meta_keyword;
@property (strong,nonatomic) NSString *meta_desc;
@property (strong,nonatomic) NSNumber *show_home_page;
@property (strong,nonatomic) NSString *active;
@property (strong,nonatomic) NSString <Optional> *created;
@property (strong,nonatomic) NSArray <Images,Optional> *images;
@property (strong,nonatomic) NSArray <ProductSuppliers,Optional> *suppliers;
@property (strong,nonatomic) NSArray <Optional,Features> *featuresList;
@end
