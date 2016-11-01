//
//  Categories.m
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize TMCat,TMtitle,OfferPrice,ActualPrice;

-(id) initWithTitle:title andCat:categories
{
    self=[super init];
    {
        TMtitle=title;
        TMCat=categories;
    }
    return self;
    
}
-(id) initWithTitle:title andPrice1:price1 andPrice2:price2
{
    self=[super init];
    {
        TMtitle=title;
        OfferPrice=price1;
        ActualPrice=price2;
    }
    return self;
}

@end
