//
//  DealsCell.h
//  nayashoppy
//
//  Created by Amerald on 26/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *WishButton;
@property (strong, nonatomic) IBOutlet UIButton *ShareButton;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *PriceLabel;
@end
