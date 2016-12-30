//
//  DetailedViewController.h
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "DealsOfTheDayViewController.h"
#import "GlobalVariables.h"
#import "AppDelegate.h"
#import "CategoriesViewController.h"

@interface DetailedViewController : ViewPagerController <ViewPagerDataSource,ViewPagerDelegate>

@property(strong,nonatomic) ViewPagerController *vp;
@property(weak,nonatomic) NSNumber *selectTab;
@end
