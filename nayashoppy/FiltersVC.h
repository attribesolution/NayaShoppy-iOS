//
//  FiltersVC.h
//  nayashoppy
//
//  Created by Amerald on 28/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ViewController.h"

@interface FiltersVC : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *FilterDTable;

@property (strong, nonatomic) IBOutlet UIView *Laoder;
@property (strong, nonatomic) IBOutlet UITableView *FilterNTable;
- (IBAction)BackButton:(id)sender;
@end
