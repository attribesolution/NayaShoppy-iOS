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
#import "Mapping.h"
#import "NewArrivals.h"
#import "SlidingImages.h"
#import "Deals.h"
#import "AllProduct.h"
#import "ProductImg.h"
#import "Filters.h"
#import "singleton.h"

@interface ApiParsing : NSObject

- (NSURLSessionDataTask *)getTopMenu:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getNewArrivals:(void (^)(NSMutableArray *newArrivals,NSMutableArray *newArrivalsImg))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (UIImage *) image:(NSString *)imgurl;
- (NSURLSessionDataTask *)Slider:(void (^)(NSArray *))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)DealsOfTheDay:(void (^)(NSMutableArray *success,NSMutableArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getAllProducts:(void (^)(NSMutableArray *products,NSMutableArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getPopularProducts:(void (^)(NSMutableArray *products,NSMutableArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;

- (NSURLSessionDataTask *)getSimilarProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;

- (NSURLSessionDataTask *)getDetails:(void (^)(NSArray *details,NSArray *generalFeatures,NSArray *supliers))success failure:(void (^)(NSError *error, NSString *message))failure;
- (NSURLSessionDataTask *)getFilters:(void (^)(NSArray *filter))success failure:(void (^)(NSError *error, NSString *message))failure;
@end
