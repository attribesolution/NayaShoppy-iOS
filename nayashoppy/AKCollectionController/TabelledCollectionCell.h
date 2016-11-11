//
//  TabelledCollectionCell.h
//  AKCollectionController
//
//  Created by kashif Saeed on 04/11/2016.
//  Copyright © 2016 AppsWallet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabelledCollectionCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *GridImage;
@property (strong, nonatomic) IBOutlet UILabel *GridName;
@property (strong, nonatomic) IBOutlet UILabel *Price;
@property (strong, nonatomic) IBOutlet UILabel *Discount;
@property (strong, nonatomic) IBOutlet UILabel *Company;


@end
