//
//  ViewController.h
//  nayashoppy
//
//  Created by Amerald on 03/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"

@interface ViewController : UIViewController<UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Lmenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *Rmenu;
@property (strong, nonatomic) IBOutlet UIView *PagerView;
@property (strong, nonatomic) PagerViewController *pager;

@end

