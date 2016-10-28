//
//  SlideImg.h
//  nayashoppy
//
//  Created by Amerald on 25/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SlideImg
@end

@interface SlideImg : JSONModel

@property (strong,nonatomic) NSNumber *id;
@property (strong,nonatomic) NSNumber *slider_id;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *link;
@property (strong,nonatomic) NSString *created;

@end
