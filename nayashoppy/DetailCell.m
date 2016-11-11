
//
//  DetailCell.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell
@synthesize priceLabel=_priceLabel;
@synthesize DiscountLabel=_DiscountLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
