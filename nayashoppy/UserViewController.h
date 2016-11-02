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

@interface UserViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *UserInfoTable;

@end
