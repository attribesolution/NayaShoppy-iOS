//
//  ReviewViewController.h
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewsCell.h"

@interface ReviewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *ReviewsTabel;
@property (strong, nonatomic) IBOutlet UITextField *ReviewTextField;
@property (strong, nonatomic) IBOutlet UIView *ReviewView;

@end
