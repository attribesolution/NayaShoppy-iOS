//
//  Categories.h
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Categories : JSONModel


@property(nonatomic,strong) NSString * TMtitle;
@property(nonatomic,strong) NSString * TMimg;

-(id) initWithTitle:title andImg:img;


@end
