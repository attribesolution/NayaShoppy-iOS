//
//  OrderViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "OrderViewController.h"
#import "UIView+UIView_Customize.h"

@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize OrderTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    OrderTable.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    [self.navigationItem.titleView titleView:@"My Order" andImg:@"Logo" andy:logoY] ;
    
}
#pragma mark - UITableDelegate Method

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return 150;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"OrderCell";
    
    OrderCell *cell = (OrderCell *)[OrderTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.OrderDate.text=@"20-Aug-2016";
    cell.OrderReturnDate.text=@"30-Aug-2016";
    cell.OrderImage.image =[UIImage imageNamed:@"icon_wallet_screen"];
    cell.OrderName.text = @"Shoes";
    cell.OrderReturn.text=@"Order Returned";
    
    return cell;
}

#pragma mark - Scroll View Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    OrderTable.alwaysBounceVertical = NO;
}

@end
