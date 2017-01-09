//
//  PagerViewController.h
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "DealsOfTheDayViewController.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"

@interface PagerViewController : ViewPagerController <ViewPagerDataSource,ViewPagerDelegate>

@property(strong,nonatomic) ViewPagerController *vp;


@end
