//
//  DetailCell.h
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *DiscountLabel;
@property (strong, nonatomic) IBOutlet UILabel *OriginalPriceLabel;
@end
