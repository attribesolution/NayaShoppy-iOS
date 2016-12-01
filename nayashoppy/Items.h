//
//  Items.h
//  nayashoppy
//
//  Created by Amerald on 24/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ItemValue.h"

@protocol Items
@end

@interface Items : JSONModel

@property (strong,nonatomic) NSNumber *key;
@property (strong,nonatomic) NSNumber *count;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSArray <ItemValue> *values;
@end
