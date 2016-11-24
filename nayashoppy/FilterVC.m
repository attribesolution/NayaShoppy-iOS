
//
//  FilterVC.m
//  nayashoppy
//
//  Created by Amerald on 24/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "FilterVC.h"

@interface FilterVC ()

@end

@implementation FilterVC
@synthesize FilterDetails,FilterNameTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FilterDetails.hidden=YES;
    
}
#pragma mark - UITableDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==100)
       return 6;
    else
       return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.FilterDetails.hidden=NO;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==100)
    {
        static NSString *simpleTableIdentifier = @"CELL";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        cell.backgroundColor=[UIColor grayColor];
        return cell;
        
    }
    else
    {
        static NSString *simpleTableIdentifier = @"CELL";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        cell.backgroundColor=[UIColor redColor];
        return cell;

        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.FilterDetails.alwaysBounceVertical = NO;
    self.FilterNameTable.alwaysBounceVertical = NO;
}




@end
