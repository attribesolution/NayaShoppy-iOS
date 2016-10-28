//
//  DealsChild.h
//  nayashoppy
//
//  Created by Amerald on 26/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol DealsChild
@end

@interface DealsChild : JSONModel

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSNumber *store_id;
@property (strong,nonatomic) NSString *brand;
@property (strong,nonatomic) NSString *link;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *image_path;
@property (strong,nonatomic) NSString *price;
@property (strong,nonatomic) NSString *offer_price;
@property (strong,nonatomic) NSString *start_date;
@property (strong,nonatomic) NSString *end_date;
@property (strong,nonatomic) NSString *availability;
@property (strong,nonatomic) NSString <Optional> *sizes;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *created;
@property (strong,nonatomic) NSString *discount;

@end
