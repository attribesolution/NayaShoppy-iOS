//
//  StoreCell.h
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *PRICE;
@property (strong, nonatomic) IBOutlet UILabel *Description;
@property (strong, nonatomic) IBOutlet UIButton *StoreButton;
@property (strong, nonatomic) IBOutlet UILabel *Offer;

@end
