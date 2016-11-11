//
//  CollectionCell.h
//  AKCollectionController
//
//  Created by kashif Saeed on 04/11/2016.
//  Copyright © 2016 AppsWallet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ListImage;
@property (strong, nonatomic) IBOutlet UILabel *ListItem;
@property (strong, nonatomic) IBOutlet UILabel *LPrice;
@property (strong, nonatomic) IBOutlet UILabel *LDiscount;
@property (strong, nonatomic) IBOutlet UILabel *LRating;
@property (strong, nonatomic) IBOutlet UILabel *LItemUser;
@property (strong, nonatomic) IBOutlet UILabel *LItemCapacity;
@property (strong, nonatomic) IBOutlet UILabel *LItemColor;


@end
