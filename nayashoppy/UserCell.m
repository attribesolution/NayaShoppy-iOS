
//
//  UserCell.m
//  nayashoppy
//
//  Created by Amerald on 24/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell
@synthesize Uimage = _Uimage;
@synthesize Ulabel= _Ulabel;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
