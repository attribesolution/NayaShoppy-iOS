
//
//  ImageCell.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize ImageView=_ImageView;
@synthesize TitleLabel =_TitleLabel;
@synthesize ShareIcon =_ShareIcon;
@synthesize WishICon=_WishICon;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
