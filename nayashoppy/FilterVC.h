//
//  FilterVC.h
//  nayashoppy
//
//  Created by Amerald on 24/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *FilterNameTable;
@property (strong, nonatomic) IBOutlet UITableView *FilterDetails;

@end
