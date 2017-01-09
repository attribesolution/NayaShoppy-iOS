//
//  DealsOfTheDayViewController.h
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealsCell.h"
#import "Categories.h"
#import "SpecificationListViewController.h"
#import "ReviewViewController.h"
#import "UserDefaults.h"
@interface DealsOfTheDayViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *DealsOfTheDayCV;


@end
