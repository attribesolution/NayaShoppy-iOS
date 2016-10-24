//
//  ApiParsing.h
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "Categories.h"
#import "GlobalVariables.h"
#import "MenuData.h"
#import "Mapping.h"
#import "SubCategories1.h"
#import "NewArrivals.h"
#import "Products.h"

@interface ApiParsing : NSObject

- (NSURLSessionDataTask *)getTopMenu:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getNewArrivals:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
-(UIImage *) image:(NSString *)imgurl;
@end
