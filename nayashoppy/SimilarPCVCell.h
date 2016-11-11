//
//  SimilarPCVCell.h
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimilarPCVCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *Image;
@property (strong, nonatomic) IBOutlet UILabel *Title;
@property (strong, nonatomic) IBOutlet UILabel *Company;
@property (strong, nonatomic) IBOutlet UIButton *WishIcon;
@property (strong, nonatomic) IBOutlet UIButton *ShareIcon;

@end
