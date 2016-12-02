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

    WishListTable.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"WishList" andImg:@"Logo" andy:logoY] ;
    [self data];
}

#pragma mark - UITableDelegate Method

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  myProducts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return 150;
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
   
    cell.price.text= [[[myProducts objectAtIndex:indexPath.section]objectAtIndex:0] objectAtIndex:1];
    
    NSURL *Url = [NSURL URLWithString:[[myProductsImg objectAtIndex:indexPath.section]objectAtIndex:0]];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak WishListCell *weakCell = cell;
    
    [cell.WishImage setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.WishImage.image = image;
                                      [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
   // NSData *imageData = [[myProductsImg objectAtIndex:indexPath.section]objectAtIndex:0];
   // cell.WishImage.image = [UIImage imageWithData:imageData];
    cell.WishItem.text = [[[myProducts objectAtIndex:indexPath.section]objectAtIndex:0]objectAtIndex:0];
   // [cell.DeleteButton addTarget:self action:@selector(OrderRemove:) forControlEvents:UIControlEventTouchUpInside];

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

-(void) data
{
    defaults = [NSUserDefaults standardUserDefaults];
    
    myProducts = [defaults objectForKey:@"Product"];
    myProducts=[[[myProducts reverseObjectEnumerator] allObjects] mutableCopy];
    myProductsImg=[defaults objectForKey:@"ProductImg"];
    myProductsImg=[[[myProductsImg reverseObjectEnumerator] allObjects] mutableCopy];
    [self.WishListTable reloadData];
}

@end
