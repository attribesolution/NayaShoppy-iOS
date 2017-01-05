//
//  WishListViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "WishListViewController.h"
#import "UIView+UIView_Customize.h"

@interface WishListViewController ()

@end

@implementation WishListViewController
@synthesize WishListTable;

- (void)viewDidLoad {
    [super viewDidLoad];

    WishListTable.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    [self.navigationItem.titleView titleView:@"WishList" andImg:@"Logo" andy:logoY];
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
  
    CGSize textSize = [[[[myProducts objectAtIndex:indexPath.section]objectAtIndex:0]objectAtIndex:0] sizeWithAttributes:@{NSFontAttributeName:[cell.WishItem font]}];
    CGFloat strikeWidth = textSize.width;
    CGFloat Dlines=(strikeWidth/cell.WishItem.frame.size.width+1)*25+25;
    
    cell.WishItem.frame=CGRectMake(cell.WishItem.frame.origin.x,cell.WishItem.frame.origin.y,cell.WishItem.frame.size.width, Dlines);
    
    cell.WishItem.text = [[[myProducts objectAtIndex:indexPath.section]objectAtIndex:0]objectAtIndex:0];
    [cell.DeleteButton addTarget:self action:@selector(OrderRemove:) forControlEvents:UIControlEventTouchUpInside];

     return cell;
}
-(void)OrderRemove:(UIButton *) sender
{
   UITableViewCell *mycell= (UITableViewCell *)[[sender superview] superview];
   NSIndexPath *ind= [self.WishListTable indexPathForCell:mycell];
   [myProducts removeObjectAtIndex:ind.section];
   [myProductsImg removeObjectAtIndex:ind.section];
   [defaults setObject:myProducts forKey:@"Product"];
   [defaults setObject:myProductsImg forKey:@"ProductImg"];
   [self.view makeToast:@"Item Deleted"];
   [self reverseArray];
   [self.WishListTable reloadData];
    
}
#pragma mark - Scroll View Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    WishListTable.alwaysBounceVertical = NO;
}

-(void) data
{
    defaults = [NSUserDefaults standardUserDefaults];
    [self reverseArray];
    [self.WishListTable reloadData];
}

-(void) reverseArray
{
    myProducts = [defaults objectForKey:@"Product"];
    myProducts=[[[myProducts reverseObjectEnumerator] allObjects] mutableCopy];
    myProductsImg=[defaults objectForKey:@"ProductImg"];
    myProductsImg=[[[myProductsImg reverseObjectEnumerator] allObjects] mutableCopy];
}
@end
