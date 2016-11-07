//
//  UserViewController.h
//  nayashoppy
//
//  Created by Amerald on 24/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCell.h"
#import "GlobalVariables.h"
#import "SignInVC.h"
#import "AppDelegate.h"
#import "WalletViewController.h"
#import "WishListCell.h"
#import "OrderViewController.h"
#import "AboutUsViewController.h"
#import "RateAppViewController.h"

@interface UserViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *UserInfoTable;

@end
