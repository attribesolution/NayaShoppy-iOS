//
//  Slider.h
//  nayashoppy
//
//  Created by Amerald on 25/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "SlideImg.h"

@protocol Slider
@end

@interface Slider : JSONModel
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSNumber *category_id;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *slider_type;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *start_date;
@property (strong,nonatomic) NSString *end_date;
@property (strong,nonatomic) NSString *link;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *created;
@property (strong,nonatomic) NSArray <SlideImg> *images;

@end
