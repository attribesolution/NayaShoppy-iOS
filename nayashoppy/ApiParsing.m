//
//  ApiParsing.m
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ApiParsing.h"

static NSString *baseUrl = @"http://nsapi.nayashoppy.com/v1/default";
static NSString *topMenuUrl = @"%@/topmenu";
static NSString *newArrivals = @"%@/newarrival";
static NSString *Dealsofday = @"%@/dealsoftheday";
static NSString *slider = @"http://nsapi.nayashoppy.com/";

@interface  ApiParsing()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ApiParsing

- (NSURLSessionDataTask *)getTopMenu:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure {
    
    NSURL *url=[self setupSessionManager:topMenuUrl];
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        Mapping *country = [[Mapping alloc] initWithString:myString  error:&error];
        
        NSString *img;
        MenuData *ob=[MenuData Items];
        for(int i=0;i<country.data.count;i++)
        {
        MainCategories *ic = country.data[i];
        if([UIScreen mainScreen].scale==2.0)
        {   img=[[ic.api_icon valueForKey:@"ios"]valueForKey:@"2x"];}
        else
        {
            img=[[ic.api_icon valueForKey:@"ios"]valueForKey:@"3x"];
        }

         Categories *Cobj=[[Categories alloc] initWithTitle:ic.title andImg:img];
            
         [ob.topmenuImg addObject:[self image:img]];
         [ob.topmenu addObject:Cobj];
        }
        success(true);
        
    }
       failure:^(NSURLSessionDataTask *operation, NSError *error) {
                     failure(error,nil); }];
    
    return task;
    
}

 - (NSURLSessionDataTask *)getNewArrivals:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure {
    
     NSURL *url=[self setupSessionManager:newArrivals];
     
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NewArrivals *newproduct = [[NewArrivals alloc] initWithString:myString  error:&error];
  
        MenuData *ob=[MenuData Items];
        for(int i=0;i<newproduct.data.count;i++)
        {
            Products *ic = newproduct.data[i];
            Images *img=ic.images[0];
            [ob.newarrivalImg addObject:[self image:img.image_path]];
            [ob.newarrival addObject:ic.product_name];
        }
        success(true);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                     failure(error,nil); }];
    
    return task;
    
}
- (NSURLSessionDataTask *)Slider:(void (^)(UIImage *img))success failure:(void (^)(NSError *error, NSString *message))failure {
    
    NSString *string = slider;
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:slider]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        SlidingImages *slider = [[SlidingImages alloc] initWithString:myString  error:&error];
        Slider *obj=slider.data[0];
        SlideImg *imgurl=obj.images[0];
        UIImage *simg=[self image:imgurl.image];
        
        success(simg);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error,nil); }];
    
    return task;
    
}
- (NSURLSessionDataTask *)DealsOfTheDay:(void (^)(BOOL success))success failure:(void (^)(NSError *error, NSString *message))failure
{
    
    NSURL *url=[self setupSessionManager:Dealsofday];
    
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
       
        Deals *newdeals = [[Deals alloc] initWithString:myString  error:&error];
        
        MenuData *ob=[MenuData Items];
        for(int i=0;i<newdeals.data.count;i++)
        {
            DealsOfDay *deals = newdeals.data[i];
            DealsChild *ch=deals.children[i];
            [ob.DealsOfTheDayImg addObject:[self image:ch.image_path]];
            
            Categories *Cobj=[[Categories alloc] initWithTitle:ch.title andPrice1:ch.price andPrice2:ch.offer_price];
            
            [ob.DealsOfTheDay addObject:Cobj];
        }

        success(true);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error,nil); }];
    
    return task;
 
}
- (NSURL *)setupSessionManager:(NSString *)suburl
{
    NSString *string = [NSString stringWithFormat:suburl,baseUrl];
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     self.sessionManager.session.configuration.timeoutIntervalForRequest = 25.0;
    return url;
    
}

-(UIImage *) image:(NSString *)imgurl
{
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                              [NSURL URLWithString:imgurl]]];
    if(image==nil)
        image=[UIImage imageNamed:@"PlaceHolder"];
    
    return image;
}
@end
