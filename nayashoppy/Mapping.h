//
//  Mapping.h
//  JsonEg
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MainCategories.h"


@interface Mapping : JSONModel

@property (strong,nonatomic) NSArray <MainCategories> *data;
@property (strong,nonatomic) NSDictionary *meta;
@end
