//
//  ImageCell.h
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UIImageView *WishICon;
@property (strong, nonatomic) IBOutlet UIImageView *ShareIcon;
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;

@end