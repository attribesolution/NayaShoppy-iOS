//
//  CouponsVC.h
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashAndCouponsData.h"
#import "CouponsCollectionViewCell.h"

@interface CouponsVC : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *cashCV;

@end
