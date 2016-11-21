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
@property(nonatomic,strong) NSMutableArray * TMCat;
@property(nonatomic,strong) NSString * OfferPrice;
@property(nonatomic,strong) NSString * ActualPrice;
@property(nonatomic,strong) NSString * BranchID;
@property(nonatomic,strong) NSString * CatID;
@property(nonatomic,strong) NSString * Ctitle;
@property(nonatomic,strong) NSString * POfferPrice;
@property(nonatomic,strong) NSString * StoreDelivery;
@property(nonatomic,strong) NSString * StorePrice;
@property(nonatomic,strong) NSString * PcatId;
@property(nonatomic,strong) NSString * PName;
@property(nonatomic,strong) NSString * Pprice;
@property(nonatomic,strong) NSString * Pslug;
@property(nonatomic,strong) NSString * StoreUrl;
@property(nonatomic,strong) NSString * StoreName;
@property(nonatomic,strong) NSString * Discount;
@property(nonatomic,strong) NSString * featurename;
@property(nonatomic,strong) NSString * featurevalue;
@property(nonatomic,strong) NSMutableArray * Supliers;

-(id) initWithTitle:title andCat:categories;
-(id) initWithFeatureName:name andFeatureValue:value;
-(id) initWithTitle:title andPrice1:price1 andPrice2:price2;
-(id) initWithTitle:title andinitWithBranchID:Bid andCatID:Cid;
-(id) initWithDilevery:delivery andinitWithurl:url andinitWithprice:price;
-(id) initWithName:title andinitWithprice:price andinitWithofferPrice:oprice andinitWithDiscount:discount andinitWithSupliers:supliers andinitWithcat:catid andinitWithslug:slug ;
-(id) initWithTitle:title andPrice:price;
@end
