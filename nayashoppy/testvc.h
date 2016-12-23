//
//  testvc.h
//  nayashoppy
//
//  Created by Amerald on 21/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobilesVC.h"
#import "ProductViewController.h"

@interface testvc : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
