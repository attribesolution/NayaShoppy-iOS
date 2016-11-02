//
//  TopMenuVc.h
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesCell.h"
#import "Categories.h"
#import "MenuData.h"
#import "AppDelegate.h"
#import "DetailedViewController.h"

@interface TopMenuVc : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *TopmenuVC;
@end
