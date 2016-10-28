//
//  ViewController.h
//  nayashoppy
//
//  Created by Amerald on 03/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "GlobalVariables.h"
#import "DealsOfTheDayViewController.h"
#import "SWRevealViewController.h"
#import "HomeViewController.h"

@interface ViewController : ViewPagerController<ViewPagerDataSource,ViewPagerDelegate,UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property(strong,nonatomic) ViewPagerController *vp;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Lmenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Rmenu;

@end

