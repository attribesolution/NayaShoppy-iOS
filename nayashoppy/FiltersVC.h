//
//  FiltersVC.h
//  nayashoppy
//
//  Created by Amerald on 28/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiltersVC : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *FilterDTable;

@property (strong, nonatomic) IBOutlet UIView *Laoder;
@property (strong, nonatomic) IBOutlet UITableView *FilterNTable;

@property (strong, nonatomic) IBOutlet UIButton *ResetFilter;
- (IBAction)ResetButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *ApplyFilter;
- (IBAction)ApplyFilterButton:(id)sender;
@end
