//
//  FeaturesDetail.h
//  nayashoppy
//
//  Created by Amerald on 15/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol FeaturesDetail
@end

@interface FeaturesDetail : JSONModel
@property (strong,nonatomic) NSString *featureName;
@property (strong,nonatomic) NSString *featureValue;
@property (nonatomic,assign) BOOL isFilter;
@end
