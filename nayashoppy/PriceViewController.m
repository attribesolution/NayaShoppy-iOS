//
//  PriceViewController.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()
{
    NSNumber *index;
    MenuData *obj;
}
@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:@"ImageAtIndex" object:nil];
    obj=[MenuData Items];
}
- (void) incomingNotification:(NSNotification *)notification{
    index = [notification object];
    

}
#pragma mark - UITableDelegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return  180;
    if(indexPath.row==1)
        return  100;
    if(indexPath.row==3)
        return 230;
    if(indexPath.row==5)
        return 109;
    if(indexPath.row==7)
        return  109;
    else
        return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *cobj=[obj.allproducts objectAtIndex:indexPath.row];
    if(indexPath.row==0)
    {
      static NSString *simpleTableIdentifier = @"ImageCell";
        
      ImageCell *cell = (ImageCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
      if (cell == nil)
      {
          NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ImageCell" owner:self options:  nil];
          cell = [nib objectAtIndex:0];
      }
      cell.ImageView.image=[obj.allproductimg objectAtIndex:[index integerValue]];
      cell.TitleLabel.text=cobj.TMtitle;
      return cell;
        
   }
 
   if (indexPath.row==3) {
        
     static NSString *simpleTableIdentifier = @"StoreCell";
   
     StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
      if (cell == nil)
      {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:self options:  nil];
         cell = [nib objectAtIndex:0];
       }
      cell.PRICE.text=cobj.OfferPrice;
      return cell;
   
    }
    /* if (indexPath.row==5) {
        
    }
    if (indexPath.row==7) {
          }*/
    if (indexPath.row==1)
    {
        static NSString *simpleTableIdentifier = @"Detail";
        
        DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        cell.priceLabel.textColor=[[GlobalVariables class] themeColor];
        cell.priceLabel.text=[cell.priceLabel.text stringByAppendingString:cobj.OfferPrice];
        cell.DiscountLabel.textColor=[[GlobalVariables class]greenColor];
        return cell;

          }
    else
    {
    static NSString *simpleTableIdentifier = @"Stores";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
        
    return cell;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.PriceTable.alwaysBounceVertical = NO;
}


@end
