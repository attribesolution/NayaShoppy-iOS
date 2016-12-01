//
//  Categories.m
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "Categories.h"

@implementation Categories

@synthesize TMCat,TMtitle,OfferPrice,ActualPrice,BranchID,CatID,Ctitle,PName,Pprice,POfferPrice,PcatId,Pslug,Supliers,StoreUrl,StoreDelivery,StorePrice,featurename,featurevalue,Discount,filterName,PImg, FilterValues,PType,Pindex;

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

-(id) initWithName:title andinitWithprice:price andinitWithofferPrice:oprice andinitWithDiscount:discount andinitWithSupliers:supliers andinitWithcat:catid andinitWithslug:slug
{
    self=[super init];
    {
        PName=title;
        Pprice=price;
        POfferPrice=oprice;
        Discount=discount;
        Supliers=supliers;
        PcatId=catid;
        Pslug=slug;

    }
    return self;

}
-(id) initWithDilevery:delivery andinitWithurl:url andinitWithprice:price{
    self=[super init];
    {
        StoreDelivery=delivery;
        StoreUrl=url;
        StorePrice=price;
    }
    return self;
    
}
-(id) initWithFeatureName:name andFeatureValue:value
{
    self=[super init];
    {
        featurename=name;
        featurevalue=value;
    }
    return self;
    
}
-(id) initWithTitle:title andPrice:price
{
    self=[super init];
    {
        PName=title;
        Pprice=price;
    }
    return self;
}
-(id) initWithFname:name andFvalue:values
{
    
    self=[super init];
    {
        filterName=name;
        FilterValues=values;
    }
    return self;
}
-(id) initWithName:name andPrice:price andImg:img andCatId:catid andSlug:slug andType:(id)type andIndex:(id)index
{
    self=[super init];
    {
        PName=name;
        Pprice=price;
        PcatId=catid;
        Pslug=slug;
        PImg=img;
        PType=type;
        Pindex=index;
    }
    return self;
}
@end
