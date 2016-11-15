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
    MenuData *obj;
    Categories *cobj;

}
@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"SimilarProduct" bundle:nil];
    self.sproduct = [coupons instantiateViewControllerWithIdentifier:@"SimilarProduct"];
   UIStoryboard *img=[UIStoryboard storyboardWithName:@"CollectionImages" bundle:nil];
    self.imgcv = [img instantiateViewControllerWithIdentifier:@"BannerImagesVC"];
    [self addChildViewController:self.imgcv];
    [self.imgcv didMoveToParentViewController:self];
    cobj=[obj.allproducts objectAtIndex:[obj.index integerValue]];

}

#pragma mark - UITableDelegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return  180;
    if(indexPath.section==1)
        return  100;
    if(indexPath.section==3)
        return 230*cobj.Supliers.count;
    if(indexPath.section==5)
        return 235;
    if(indexPath.section==8)
        return 180;
    else
        return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8 + cobj.Supliers.count;
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
{   int k=0;
    if(indexPath.section==0)
    {
    ImageCell *cell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        self.imgcv.view.frame = cell.ImgCollView.bounds;
        [cell.ImgCollView addSubview:self.imgcv.view];
        cell.TitleLabel.text=cobj.PName;
        return cell;
   }
 
    if (indexPath.section==1)
    {
        static NSString *simpleTableIdentifier = @"Detail";
        
        DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        cell.priceLabel.textColor=[[GlobalVariables class] themeColor];
        cell.priceLabel.text=[@"Rs " stringByAppendingString:cobj.Pprice];
        cell.DiscountLabel.textColor=[[GlobalVariables class]greenColor];
        return cell;
        
    }
    
    
   if (indexPath.section==3+k) {
        
     static NSString *simpleTableIdentifier = @"StoreCell";
   
     StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
      if (cell == nil)
      {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:self options:  nil];
         cell = [nib objectAtIndex:0];
       }
      Categories *sup=[cobj.Supliers objectAtIndex:k];
      cell.PRICE.text=sup.StorePrice;

      cell.Description.text=sup.StoreDelivery;
      return cell;
   
    }
    
    if (indexPath.section==k+1)
    {
        static NSString *simpleTableIdentifier = @"Specification";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        return cell;
    }

    if(indexPath.section==k+2)
    {
        static NSString *simpleTableIdentifier = @"SpecificationCell";
        
        SpecificationCell *cell = (SpecificationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecificationCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
        
    }
    
    if (indexPath.section==k+3) {
        
        static NSString *simpleTableIdentifier = @"ReviewCell";
        
        ReviewCell *cell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }
    
     if (indexPath.section==k+4) {
         static NSString *simpleTableIdentifier = @"Similar Products";
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
         
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
         }
         
         return cell;
          }
   
    if (indexPath.section==k+5)
   {
        SimilarProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimilarProduct" forIndexPath:indexPath];
        self.sproduct.view.frame = cell.SimilarProductView.bounds;
       [cell.SimilarProductView addSubview:self.sproduct.view];
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
