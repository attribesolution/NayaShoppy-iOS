//
//  ItemValue.h
//  nayashoppy
//
//  Created by Amerald on 25/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ItemValue
@end

@interface ItemValue : JSONModel

@property (strong,nonatomic) NSNumber *key;
@property (strong,nonatomic) NSNumber *count;
@property (strong,nonatomic) NSString *name;

@end
