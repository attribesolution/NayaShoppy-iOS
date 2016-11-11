//
//  SpecificationsViewController.h
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "GlobalVariables.h"
#import "PriceViewController.h"

@interface SpecificationsViewController : ViewPagerController <ViewPagerDataSource,ViewPagerDelegate>

@property(strong,nonatomic) ViewPagerController *vp;
@property(copy,nonatomic) NSString *title;
@end
