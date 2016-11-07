//
//  WishListViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "WishListViewController.h"

@interface WishListViewController ()
{
    MenuData *ob;
}
@end

@implementation WishListViewController
@synthesize WishListTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    ob=[MenuData Items];
    WishListTable.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"WishList" andImg:@"Logo" andy:logoY] ;
}

#pragma mark - UITableDelegate Method

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ob.newarrival.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"WishListCell";
    
    WishListCell *cell = (WishListCell *)[WishListTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WishListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    cell.price.text=@"2000";
    cell.actualPrice.text=@"3000";
    cell.WishImage.image = [ob.newarrivalImg objectAtIndex:indexPath.section];
    cell.WishItem.text = [ob.newarrival objectAtIndex:indexPath.section];
    [cell.DeleteButton addTarget:self action:@selector(OrderRemove:) forControlEvents:UIControlEventTouchUpInside];

     return cell;
}
-(void)OrderRemove:(UIButton *) sender
{
    
   UITableViewCell *mycell= (UITableViewCell *)[[sender superview] superview];
    mycell.backgroundColor=[UIColor darkGrayColor];
  /* NSIndexPath *ind= [self.OrderTable indexPathForCell:mycell];
   [ItemsOrder removeObjectAtIndex:ind.row];
   [ self.view makeToast:@"Item Deleted"];
   NSInteger diff=[TPrice integerValue]-totalPrice;
   TPrice=[NSString stringWithFormat:@"%2lu", (unsigned long)diff];
   [ OrderTable reloadData];*/
    
}
#pragma mark - Scroll View Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    WishListTable.alwaysBounceVertical = NO;
}

@end
