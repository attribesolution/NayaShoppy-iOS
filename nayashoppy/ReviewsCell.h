//
//  ReviewsCell.h
//  nayashoppy
//
//  Created by Amerald on 05/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *ProfileName;
@property (strong, nonatomic) IBOutlet UILabel *ReviewDate;
@property (strong, nonatomic) IBOutlet UILabel *Review;

@end
