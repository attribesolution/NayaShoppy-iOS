//
//  ProductImg.h
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ProductImg : JSONModel
@property (strong,nonatomic) NSNumber < Optional >*id;
@property (strong,nonatomic) NSNumber < Optional >*id_product;
@property (strong,nonatomic) NSString < Optional >*image;
@property (strong,nonatomic) NSString < Optional >*image_path;
@property (strong,nonatomic) NSString < Optional >*created;

@end
