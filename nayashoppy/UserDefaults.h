//
//  UserDefaults.h
//  nayashoppy
//
//  Created by Amerald on 09/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Toast.h"

extern NSMutableArray *categories,*myProducts,*myProductsImg;
extern  NSUserDefaults *defaults;

@interface UserDefaults : NSObject

+(void) AddWhishList:(NSString *)name :(NSString *)price :(NSString *) image :(UIView *) view;
+(BOOL) IsFound:(NSString*) name;

@end
