//
//  OrderViewController.h
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCell.h"

@interface OrderViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *OrderTable;

@end
