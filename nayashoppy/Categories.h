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
@property(nonatomic,strong) NSString * Color;
@property(nonatomic,strong) NSString * Capacity;
@property(nonatomic,strong) NSString * User;
@property(nonatomic,strong) NSString * PName;
@property(nonatomic,strong) NSString * Pprice;

-(id) initWithTitle:title andCat:categories;
-(id) initWithTitle:title andPrice1:price1 andPrice2:price2;
-(id) initWithTitle:title andinitWithBranchID:Bid andCatID:Cid;
//-(id) initWithName:title andinitWithprice:price;
-(id) initWithName:title andinitWithprice:price andinitWithuser:user andinitWithcapcity:capacity andinitWithcolor:color;

@end
