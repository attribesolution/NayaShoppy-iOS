//
//  Categories.m
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize TMCat,TMtitle,OfferPrice,ActualPrice,BranchID,CatID,Ctitle,PName,Pprice,Capacity,Color,User;

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

-(id) initWithTitle:title andinitWithBranchID:Bid andCatID:Cid
{
    self=[super init];
    {
        BranchID=Bid;
        CatID=Cid;
        Ctitle=title;
    }
    return self;
}

-(id) initWithName:title andinitWithprice:price andinitWithuser:user andinitWithcapcity:capacity andinitWithcolor:color
{
    self=[super init];
    {
        PName=title;
        Pprice=price;
        Color=color;
        Capacity=capacity;
        User=user;
    }
    return self;

}

@end
