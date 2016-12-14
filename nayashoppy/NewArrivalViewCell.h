//
//  NewArrivalViewCell.h
//  nayashoppy
//
//  Created by Amerald on 21/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewArrivalViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *NAimg;
@property (strong, nonatomic) IBOutlet UILabel *NAProductName;
@property (strong, nonatomic) IBOutlet UILabel *Price;
@property (strong, nonatomic) IBOutlet UILabel *Discount;
@property (strong, nonatomic) IBOutlet UILabel *Company;

@end
