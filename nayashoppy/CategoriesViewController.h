//
//  CategoriesViewController.h
//  nayashoppy
//
//  Created by Amerald on 17/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVariables.h"
#import "CouponsCollectionViewCell.h"
#import "NewArrivalViewCell.h"

@interface CategoriesViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *couponsLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *coupons;
@property(strong,nonatomic)   NSMutableDictionary *jsonDic;
@property (strong, nonatomic) IBOutlet UIView *LoadingView;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *NewArrivalCv;

@end
