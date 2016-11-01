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

-(id) initWithTitle:title andCat:categories;
-(id) initWithTitle:title andPrice1:price1 andPrice2:price2;



@end
