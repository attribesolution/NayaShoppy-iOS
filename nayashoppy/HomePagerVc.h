//
//  HomePagerVc.h
//  nayashoppy
//
//  Created by Amerald on 01/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"

@interface HomePagerVc : ViewPagerController <ViewPagerDataSource,ViewPagerDelegate,UISearchBarDelegate>

@property(strong,nonatomic) ViewPagerController *vp;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *Lmenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Rmenu;
@end
