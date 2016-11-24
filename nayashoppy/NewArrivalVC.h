//
//  NewArrivalVC.h
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewArrivalViewCell.h"
#import "MenuData.h"
//#import "NewArrivalsViewController.h"
#import "AppDelegate.h"
#import "SpecificationsViewController.h"
#import "PriceViewController.h"

@interface NewArrivalVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *NewarrivalCv;

@end
