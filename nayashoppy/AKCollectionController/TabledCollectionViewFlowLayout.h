//
//  TabledCollectionViewFlowLayout.h
//  AKCollectionController
//
//  Created by kashif Saeed on 02/11/2016.
//  Copyright © 2016 AppsWallet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabledCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) UIEdgeInsets itemInsets;

@property (nonatomic) CGFloat interItemSpacingY;
@end
