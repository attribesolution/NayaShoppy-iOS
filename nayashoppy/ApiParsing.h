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
#import "NewArrivals.h"
#import "SlidingImages.h"
#import "Deals.h"
#import "AllProduct.h"
#import "ProductImg.h"

@interface ApiParsing : NSObject

- (NSURLSessionDataTask *)getTopMenu:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getNewArrivals:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (UIImage *) image:(NSString *)imgurl;
- (NSURLSessionDataTask *)Slider:(void (^)(UIImage *))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)DealsOfTheDay:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getAllProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;
- (NSURLSessionDataTask *)getPopularProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;

- (NSURLSessionDataTask *)getSimilarProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure ;

- (NSURLSessionDataTask *)getDetails:(void (^)(NSArray *details))success failure:(void (^)(NSError *error, NSString *message))failure ;
@end
