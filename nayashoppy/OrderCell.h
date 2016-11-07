//
//  OrderCell.h
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *OrderImage;
@property (strong, nonatomic) IBOutlet UILabel *OrderName;
@property (strong, nonatomic) IBOutlet UILabel *OrderReturn;
@property (strong, nonatomic) IBOutlet UILabel *OrderReturnDate;
@property (strong, nonatomic) IBOutlet UILabel *OrderDate;

@end
