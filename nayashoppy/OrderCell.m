
//
//  OrderCell.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

@synthesize OrderDate = _OrderDate;
@synthesize OrderImage = _OrderImage;
@synthesize OrderName = _OrderName;
@synthesize OrderReturn = _OrderReturn;
@synthesize OrderReturnDate = _OrderReturnDate;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
