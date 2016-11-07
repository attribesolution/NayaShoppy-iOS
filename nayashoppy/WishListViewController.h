//
//  WishListViewController.h
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishListCell.h"
#import "Categories.h"
#import "MenuData.h"
#import "GlobalVariables.h"

@interface WishListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *WishListTable;

@end
