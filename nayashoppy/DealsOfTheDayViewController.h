//
//  DealsOfTheDayViewController.h
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuData.h"
#import "DealsCell.h"
#import "Categories.h"
#import "MenuData.h"
#import "SpecificationListViewController.h"
#import "ReviewViewController.h"

@interface DealsOfTheDayViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *DealsOfTheDayCV;
@property (strong, nonatomic) IBOutlet UIView *myView;

@end
