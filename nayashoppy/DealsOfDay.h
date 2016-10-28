//
//  DealsOfDay.h
//  nayashoppy
//
//  Created by Amerald on 26/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DealsChild.h"

@protocol DealsOfDay
@end

@interface DealsOfDay : JSONModel

@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *site_url;
@property (strong,nonatomic) NSString *data_url;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSArray <DealsChild> *children;

@end
