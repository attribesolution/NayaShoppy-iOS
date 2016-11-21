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
static NSString *allProducts = @"http://nsapi.nayashoppy.com/v1/catalog/";
static NSString *slider = @"http://nsapi.nayashoppy.com/";
static NSString *details = @"http://nsapi.nayashoppy.com/v1/catalog/detail/";

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
        Categories *Cobj;
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
           
           NSMutableArray *subsubcat=[[NSMutableArray alloc]init];
           NSMutableArray *ParentChild=[[NSMutableArray alloc]init];
          
            for(int k=0;k<ic.children.count;k++)
            {
                
            SubCategories1 *child=ic.children[k];
            NSMutableArray *subCat=[[NSMutableArray alloc]init];
            NSMutableArray *Catid=[[NSMutableArray alloc]init];
            [subCat addObject:child.title];
            for (int j=0; j<child.children.count; j++) {
                SubCategories2 *subchild =child.children[j];
                [subCat addObject:subchild.title];
                Cobj=[[Categories alloc] initWithTitle:subchild.title andinitWithBranchID:subchild.brand_id andCatID:subchild.category_id];
                [Catid addObject:Cobj];
            }
                [ParentChild addObject:Catid];
                [subsubcat addObject:subCat];
            }
            Cobj=[[Categories alloc]initWithTitle:ic.title andCat:ParentChild];
            [ob.CatBranchIDs addObject:Cobj];
            
         Cobj=[[Categories alloc] initWithTitle:ic.title andCat:subsubcat];
            
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
        AllProduct *newproduct = [[AllProduct alloc] initWithString:myString  error:&error];

        MenuData *ob=[MenuData Items];
        NSMutableArray *allproduct,*allproductimg,*productimgs,*supliers;
        allproduct=[[NSMutableArray alloc]init];
        allproductimg=[[NSMutableArray alloc]init];
        Categories *cobj;
        
        for(int i=0;i<newproduct.data.count;i++)
        {
            supliers=[[NSMutableArray alloc]init];
            productimgs=[[NSMutableArray alloc]init];
            ProductDetails *ic = newproduct.data[i];
            if(ic.images.count==0)
                [ob.newarrivalImg addObject:[self image:nil]];
            else{
                for(int j=0;j<ic.images.count;j++)
                {
                    ProductImg *img=ic.images[j];
                    [productimgs addObject:[self image:img.image_path]];
                }
                [ob.newarrivalImg addObject:productimgs];}
            for(int k=0;k<ic.suppliers.count;k++)
            {
               ProductSuppliers *sup= ic.suppliers[k];
               cobj=[[Categories alloc]initWithDilevery:sup.delivery andinitWithurl:sup.url andinitWithprice:sup.price];
               [supliers addObject:cobj];
            }
            
            
            cobj=[[Categories alloc] initWithName:ic.product_name andinitWithprice:ic.lowest_price andinitWithofferPrice:ic.original_price andinitWithDiscount:ic.discount andinitWithSupliers:supliers andinitWithcat:ic.categories_category_id andinitWithslug:ic.slug ];
            [ob.newarrival addObject:cobj];
            
        }

        success(true);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                     failure(error,nil); }];
    
    return task;
    
}
- (NSURLSessionDataTask *)getDetails:(void (^)(NSArray *details))success failure:(void (^)(NSError *error, NSString *message))failure
{
    MenuData *ob=[MenuData Items];
    NSDictionary *keyValue=[[NSDictionary alloc]init];
    keyValue= @{
                @"slug":ob.slug,
                      };
    NSString *string = details;
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:string]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:keyValue progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        MenuData *obj=[MenuData Items];
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        AllProduct *newproduct = [[AllProduct alloc] initWithString:myString  error:&error];
        
        NSMutableArray *features,*allfeatures;
       
        allfeatures=[[NSMutableArray alloc]init];
        Categories *cobj;
        
            ProductDetails *ic = newproduct.data[0];
        
            for(int k=0;k<ic.featuresList.count;k++)
            {
                features=[[NSMutableArray alloc]init];
                Features *feature=ic.featuresList[k];
                [features addObject:feature.featureGroupName];
                for(int j=0;j<feature.featureValues.count;j++)
                {
                    FeaturesDetail *fd=feature.featureValues[j];
                   
                    if([fd.featureName isEqualToString:@"Display Size"] ||[fd.featureName isEqualToString:@"Operating System"] ||[fd.featureName isEqualToString:@"Internal Storage"] ||[fd.featureName isEqualToString:@"RAM"] ||[fd.featureName isEqualToString:@"Primary Camera"] ||[fd.featureName isEqualToString:@"Secondary Camera"]
                       ||[fd.featureName isEqualToString:@"Network Type"])
                    {
                    
                        cobj=[[Categories alloc]initWithFeatureName:fd.featureName andFeatureValue:fd.featureValue];
                        [obj.GernalFeatures addObject:cobj];
                    }

                    cobj=[[Categories alloc]initWithFeatureName:fd.featureName andFeatureValue:fd.featureValue];
                    [features addObject:cobj];
                }
                [allfeatures addObject:features];
            }
        
        success(allfeatures);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error,nil); }];
    
    return task;
    

    
}
- (NSURLSessionDataTask *)getAllProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure {
    
     MenuData *ob=[MenuData Items];
     NSDictionary *keyValue=[[NSDictionary alloc]init];
                           keyValue= @{      @"category_id":ob.CatId,
                                             @"brand_id":ob.BranchId,
                                             @"page":@1,
                                             
                                             };

    
    NSString *string = allProducts;
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:string]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
   
        NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:keyValue progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
       
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        AllProduct *newproduct = [[AllProduct alloc] initWithString:myString  error:&error];
            
        NSMutableArray *allproduct,*allproductimg,*productimgs,*supliers;
        allproduct=[[NSMutableArray alloc]init];
        allproductimg=[[NSMutableArray alloc]init];
        Categories *cobj;
            
        for(int i=0;i<newproduct.data.count;i++)
        {
            supliers=[[NSMutableArray alloc]init];
            productimgs=[[NSMutableArray alloc]init];
            ProductDetails *ic = newproduct.data[i];
            if(ic.images.count==0)
                [allproductimg addObject:[self image:nil]];
            else{
                for(int j=0;j<ic.images.count;j++)
                {
                ProductImg *img=ic.images[j];
                [productimgs addObject:[self image:img.image_path]];
                }
                [allproductimg addObject:productimgs];}
            for(int k=0;k<ic.suppliers.count;k++)
            {
                ProductSuppliers *sup= ic.suppliers[k];
                cobj=[[Categories alloc]initWithDilevery:sup.delivery andinitWithurl:sup.url andinitWithprice:sup.price];
                [supliers addObject:cobj];
            }
           
           
            cobj=[[Categories alloc] initWithName:ic.product_name andinitWithprice:ic.lowest_price andinitWithofferPrice:ic.original_price andinitWithDiscount:ic.discount andinitWithSupliers:supliers andinitWithcat:ic.categories_category_id andinitWithslug:ic.slug ];
            [allproduct addObject:cobj];

        }
        
        success(allproduct,allproductimg);
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error,nil); }];
    
    return task;
    
}

- (NSURLSessionDataTask *)getPopularProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure {
    
    
    MenuData *ob=[MenuData Items];
    NSDictionary *keyValue=[[NSDictionary alloc]init];
    keyValue= @{      @"category_id":ob.CatId,
                      @"brand_id":ob.BranchId,
                      @"page":@1,
                      
                      };
    
    
    NSString *string = @"http://nsapi.nayashoppy.com/v1/catalog/popularproducts";
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:string]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:keyValue progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        AllProduct *newproduct = [[AllProduct alloc] initWithString:myString  error:&error];
            NSMutableArray *allproduct,*allproductimg,*productimgs,*supliers;
        allproduct=[[NSMutableArray alloc]init];
        allproductimg=[[NSMutableArray alloc]init];
        Categories *cobj;
        
        for(int i=0;i<newproduct.data.count;i++)
        {
            supliers=[[NSMutableArray alloc]init];
            productimgs=[[NSMutableArray alloc]init];
            ProductDetails *ic = newproduct.data[i];
            if(ic.images.count==0)
                [allproductimg addObject:[self image:nil]];
            else{
                for(int j=0;j<ic.images.count;j++)
                {
                    ProductImg *img=ic.images[j];
                    [productimgs addObject:[self image:img.image_path]];
                }
                [allproductimg addObject:productimgs];}
            for(int k=0;k<ic.suppliers.count;k++)
            {
                ProductSuppliers *sup= ic.suppliers[k];
                cobj=[[Categories alloc]initWithDilevery:sup.delivery andinitWithurl:sup.url andinitWithprice:sup.price];
                [supliers addObject:cobj];
            }
            
            
            cobj=[[Categories alloc] initWithName:ic.product_name andinitWithprice:ic.lowest_price andinitWithofferPrice:ic.original_price andinitWithDiscount:ic.discount andinitWithSupliers:supliers andinitWithcat:ic.categories_category_id andinitWithslug:ic.slug ];
            [allproduct addObject:cobj];
            
        }
        
        success(allproduct,allproductimg);
        
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        failure(error,nil); }];
    
    return task;
    
}

- (NSURLSessionDataTask *)getSimilarProducts:(void (^)(NSArray *products,NSArray *img))success failure:(void (^)(NSError *error, NSString *message))failure {
    
    
    MenuData *ob=[MenuData Items];
    NSDictionary *keyValue=[[NSDictionary alloc]init];
    keyValue= @{      @"category_id":ob.PCatId,
                      @"price":ob.PPrice,
                                          };
    
    
    NSString *string = @"http://nsapi.nayashoppy.com/v1/catalog/similarcatalog";
    NSURL *url = [NSURL URLWithString:string];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:string]];
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [self.sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    self.sessionManager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSURLSessionDataTask *task =[self.sessionManager GET:url.absoluteString parameters:keyValue progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSError *error;
        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:dictionary options:0 error:&error];
        NSString * myString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        AllProduct *newproduct = [[AllProduct alloc] initWithString:myString  error:&error];
        NSMutableArray *allproduct,*allproductimg,*productimgs,*supliers;
        allproduct=[[NSMutableArray alloc]init];
        allproductimg=[[NSMutableArray alloc]init];
        Categories *cobj;
        
        for(int i=0;i<newproduct.data.count;i++)
        {
            supliers=[[NSMutableArray alloc]init];
            productimgs=[[NSMutableArray alloc]init];
            ProductDetails *ic = newproduct.data[i];
            if(ic.images.count==0)
                [allproductimg addObject:[self image:nil]];
            else{
                for(int j=0;j<ic.images.count;j++)
                {
                    ProductImg *img=ic.images[j];
                    [productimgs addObject:[self image:img.image_path]];
                }
                [allproductimg addObject:productimgs];}
            if([ic.supplier_count integerValue]==0)
            {
                cobj=[[Categories alloc]initWithDilevery:ic.delivery andinitWithurl:ic.url andinitWithprice:ic.lowest_price];
                [supliers addObject:cobj];
            }
            for(int k=0;k<ic.suppliers.count;k++)
            {
                ProductSuppliers *sup= ic.suppliers[k];
                cobj=[[Categories alloc]initWithDilevery:sup.delivery andinitWithurl:sup.url andinitWithprice:sup.price];
                [supliers addObject:cobj];
            }
            cobj=[[Categories alloc] initWithName:ic.product_name andinitWithprice:ic.lowest_price andinitWithofferPrice:ic.original_price andinitWithDiscount:ic.discount andinitWithSupliers:supliers andinitWithcat:ic.categories_category_id andinitWithslug:ic.slug ];
            [allproduct addObject:cobj];
            
        }
        
        success(allproduct,allproductimg);
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
