//
//  Features.h
//  nayashoppy
//
//  Created by Amerald on 15/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "FeaturesDetail.h"

@protocol Features
@end

@interface Features : JSONModel
@property (strong,nonatomic) NSString *featureGroupName;
@property (strong,nonatomic) NSArray <FeaturesDetail> *featureValues;
@end
