//
//  SlidingImages.h
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Slider.h"

@interface SlidingImages : JSONModel
@property (strong,nonatomic) NSArray <Slider> *data;
@property (strong,nonatomic) NSDictionary *meta;
@end
