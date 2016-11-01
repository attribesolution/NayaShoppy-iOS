//
//  Images.h
//  nayashoppy
//
//  Created by Amerald on 24/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Images
@end

@interface Images : JSONModel

@property (strong,nonatomic) NSNumber < Optional >*id;
@property (strong,nonatomic) NSNumber < Optional >*id_product;
@property (strong,nonatomic) NSString < Optional >*image;
@property (strong,nonatomic) NSString < Optional >*image_path;
@property (strong,nonatomic) NSString < Optional >*created;
@end
