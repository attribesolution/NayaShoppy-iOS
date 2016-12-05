//
//  GridCollectionViewFlowLayout.h
//  AKCollectionController
//
//  Created by kashif Saeed on 04/11/2016.
//  Copyright © 2016 AppsWallet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCollectionViewFlowLayout : UICollectionViewLayout
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@end
