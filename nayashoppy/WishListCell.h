//
//  WishListCell.h
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WishListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *WishImage;
@property (strong, nonatomic) IBOutlet UILabel *WishItem;
@property (strong, nonatomic) IBOutlet UILabel *WishCompany;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *actualPrice;
@property (strong, nonatomic) IBOutlet UIButton *DeleteButton;

@end
