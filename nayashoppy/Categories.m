//
//  Categories.m
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize TMimg,TMtitle;

-(id) initWithTitle:title andImg:img
{
    self=[super init];
    {
        TMtitle=title;
        TMimg=img;
    }
    return self;
    
}

@end
