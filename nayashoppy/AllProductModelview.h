//
//  AllProductModelview.h
//  nayashoppy
//
//  Created by Amerald on 10/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSMutableArray *allproductimg,*allproducts,*popularproductimg,*popularproducts;
extern int i;

@interface AllProductModelview : NSObject


@property(strong,nonatomic) NSMutableArray *allproducts,*popularproducts,*popularproductimg,*allproductimg;
+(void) ApiData: (NSString *)catId andBranch:(NSString*)branchId andPage:(NSNumber *)page andtag:(int)tag Aproduct:(NSArray *)allproduct Pproduct:(NSArray *)pproduct Aproductimg:(NSArray *)APimg Pproductimg:(NSArray *)PPimg ViewCon:(NSString*) vc;

@end
