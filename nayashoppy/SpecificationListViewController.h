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
#import "MenuData.h"
#import "Categories.h"
#import "SpecificationCell.h"
#import "PriceViewController.h"
#import "SimilarProductVC.h"

@interface SpecificationListViewController : UIViewController<SKSTableViewDelegate>

@property (strong, nonatomic) IBOutlet SKSTableView *myTable;

@end
