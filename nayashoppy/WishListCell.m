//
//  WishListCell.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "WishListCell.h"

@implementation WishListCell

@synthesize WishCompany = _WishCompany;
@synthesize WishImage = _WishImage;
@synthesize WishItem = _WishItem;
@synthesize price = _price;
@synthesize actualPrice = _actualPrice;

- (void)awakeFromNib {
    
    self.WishCompany.layer.cornerRadius = 15;
    self.WishCompany.clipsToBounds = YES;
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
