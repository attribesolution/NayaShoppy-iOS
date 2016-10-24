//
//  SideMenuViewController.h
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuData.h"
#import "SideMenu.h"
#import "Categories.h"
#import "GlobalVariables.h"

@interface SideMenuViewController : UIViewController<UITableViewDataSource,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *sidetable;

@end
