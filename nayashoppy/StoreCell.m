//
//  StoreCell.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "StoreCell.h"

@implementation StoreCell
@synthesize PRICE=_PRICE;
@synthesize Offer=_Offer;
@synthesize Description=_Description;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
