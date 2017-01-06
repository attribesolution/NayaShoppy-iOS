//
//  MobilesVC.h
//  nayashoppy
//
//  Created by Amerald on 22/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecificationsViewController.h"
#import "DGActivityIndicatorView.h"
#import "TabelledCollectionCell.h"
#import "DealsCell.h"

@interface MobilesVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *BackButton;
@property (strong, nonatomic) IBOutlet UIImageView *BarImage;
@property (strong, nonatomic) IBOutlet UIView *AllPLoader;
@property (strong, nonatomic) IBOutlet UIView *TitleView;
@property (strong, nonatomic) IBOutlet UIView *BarView;
@property (strong, nonatomic) IBOutlet UICollectionView *allProduct;
@property (strong, nonatomic) IBOutlet UICollectionView *PopularProduct;
@property (strong, nonatomic) IBOutlet UIView *PPLoader;
@property(copy,nonatomic) NSString *title,*branchId,*catId;
@property (strong, nonatomic) NSNumber *page;
@end
