
//
//  EmptyView.m
//  nayashoppy
//
//  Created by Amerald on 13/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

-(void)awakeFromNib {
    //Note that you must change @”BNYSharedView’ with whatever your nib is named
    [[NSBundle mainBundle] loadNibNamed:@"EmptyView" owner:self options:nil];
    [self addSubview: self.emptyview];
}

@end
