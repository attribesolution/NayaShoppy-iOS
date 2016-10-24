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

@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSNumber *id_product;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *image_path;
@property (strong,nonatomic) NSString *created;
@end
