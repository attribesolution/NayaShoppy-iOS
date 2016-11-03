//
//  UINavigationItem+Customize.h
//  nayashoppy
//
//  Created by kashif Saeed on 03/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (Customize)
-(void)setLeftBarItemsForProductView:(NSArray*)items;
-(void)setRightBarItemsForProductView:(NSArray*)items;
-(void) titleView:(NSString *) title1 andImg:(NSString *) img andy:(CGFloat) y;
@end
