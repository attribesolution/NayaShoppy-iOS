//
//  ProductViewController.h
//  nayashoppy
//
//  Created by kashif Saeed on 03/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "GridListViewController.h"

@interface ProductViewController : ViewPagerController<ViewPagerDataSource,ViewPagerDelegate>
@property(strong,nonatomic) GridListViewController *vc;
@property(copy,nonatomic) NSString *title;
@end
