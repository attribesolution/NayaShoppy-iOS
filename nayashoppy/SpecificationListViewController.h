//
//  SpecificationListViewController.h
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface SpecificationListViewController : UIViewController<SKSTableViewDelegate>

@property (strong, nonatomic) IBOutlet SKSTableView *myTable;

@end
