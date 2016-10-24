//
//  SubCategories2.h
//  JsonEg
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol SubCategories2
@end

@interface SubCategories2 : JSONModel

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *id;
@property (strong,nonatomic) NSNumber *category_id;
@property (strong,nonatomic) NSString *slug;
@property (strong,nonatomic) NSNumber *brand_id;
@property (strong,nonatomic) NSNumber *parent_id;
@property (strong,nonatomic) NSNumber *type;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSArray *others;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *meta_title;
@property (strong,nonatomic) NSString *meta_keyword;
@property (strong,nonatomic) NSString *meta_desc;
@property (strong,nonatomic) NSString *menu_type;
@property (strong,nonatomic) NSNumber *sort_order;
@property (strong,nonatomic) NSString *image_name;
@property (strong,nonatomic) NSNumber *show_on_app;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *created;
@property (strong,nonatomic) NSDictionary *images;
@property (strong,nonatomic) NSDictionary *api_icon;
@end
