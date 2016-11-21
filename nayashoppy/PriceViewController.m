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
    UIImage *Pimg;
    MenuData *obj;
    Categories *cobj;
    ImageCell *imgcell;

}
@property(strong,nonatomic) SimilarProductVC *sproduct;
@property (strong, nonatomic) SpecificationListViewController *cvc;
@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    [self arrayObject];
    [self Parsedetails];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshTable" object:nil];
}
-(void)refreshView:(NSNotification *) notification {
    
    [self.PriceTable reloadData];
}

#pragma mark - UITableDelegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return  180;
    if(indexPath.section==1)
        return  100;
    if(indexPath.section==3)
        return 230;
    if(indexPath.section==7)
        return 180;
    if(indexPath.section==9)
        return 220;
    else
        return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==3)
        return cobj.Supliers.count;
    if(section==5)
        return obj.GernalFeatures.count;
    else
       return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
    imgcell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        self.imgcv.view.frame =imgcell.ImgCollView.bounds;
        [imgcell.ImgCollView addSubview:self.imgcv.view];
        imgcell.TitleLabel.text=cobj.PName;
        [imgcell.WishIcon addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
        return imgcell;
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
        cell.OriginalPriceLabel.text=[@"Rs " stringByAppendingString:cobj.POfferPrice];
        cell.DiscountLabel.text=[[@"( " stringByAppendingString:cobj.Discount ] stringByAppendingString:@" % OFF)"];
        return cell;
        
    }
    
    
   if (indexPath.section==3) {
        
     static NSString *simpleTableIdentifier = @"StoreCell";
   
     StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
      if (cell == nil)
      {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StoreCell" owner:self options:  nil];
         cell = [nib objectAtIndex:0];
       }
      
      Categories *sup=[cobj.Supliers objectAtIndex:indexPath.row];
      cell.PRICE.text=sup.StorePrice;
      cell.Description.text=sup.StoreDelivery;
      cell.StoreButton.tag=indexPath.row;
      [cell.StoreButton addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
      return cell;
   
    }
    
    if (indexPath.section==4)
    {
        static NSString *simpleTableIdentifier = @"Specification";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        
        return cell;
    }

    if(indexPath.section==5)
    {
        static NSString *simpleTableIdentifier = @"SpecificationCell";
        
        SpecificationCell *cell = (SpecificationCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecificationCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        Categories *sobj=[obj.GernalFeatures objectAtIndex:indexPath.row];
        cell.name.text = sobj.featurename;
        cell.value.text=sobj.featurevalue;
      //  cell.name.attributedText
        return cell;
        
    }
  
    
    if (indexPath.section==6) {
        
        static NSString *simpleTableIdentifier = @"SpecificationButtonCell";
        
        SpecificationButtonCell *cell = (SpecificationButtonCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecificationButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.SpecificationButton addTarget:self action:@selector(GoToSpecifications:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

       }

    if (indexPath.section==7) {
        
        static NSString *simpleTableIdentifier = @"ReviewCell";
        
        ReviewCell *cell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }
    
     if (indexPath.section==8) {
         static NSString *simpleTableIdentifier = @"Sproduct";
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
         
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
         }
         
         return cell;
          }
   
    if (indexPath.section==9)
   {
        SimilarProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimilarProduct" forIndexPath:indexPath];
        self.sproduct.view.frame = cell.SimilarProductView.bounds;
        self.sproduct.XYZDelegate = (SpecificationsViewController *)[self.navigationController topViewController];
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

#pragma mark - Delegate Methods

-(void)viewWillDisappear:(BOOL)animated
{
    [self refreshTableView];
    
}
-(void) refreshTableView
{
    [self.PriceTable deselectRowAtIndexPath:[self.PriceTable indexPathForSelectedRow] animated:NO];
    [self.PriceTable setContentOffset:CGPointZero animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.PriceTable.alwaysBounceVertical = NO;
}

-(void) openURL:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: sup.StoreUrl]];
}
-(void) GoToSpecifications :(UIButton *) sender
{
    obj.tabindex=[NSNumber numberWithInt:1];
    if([self.ShowListDelegate respondsToSelector:@selector(showList)])
        [self.ShowListDelegate showList];
}
-(void) Parsedetails
{
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"SimilarProduct" bundle:nil];
    self.sproduct = [coupons instantiateViewControllerWithIdentifier:@"SimilarProduct"];
    UIStoryboard *img=[UIStoryboard storyboardWithName:@"CollectionImages" bundle:nil];
    self.imgcv = [img instantiateViewControllerWithIdentifier:@"BannerImagesVC"];
    [self addChildViewController:self.imgcv];
    [self.imgcv didMoveToParentViewController:self];
    }

-(void) arrayObject
{
    if([obj.PType isEqualToString:@"AllProducts"])
    {
        cobj=[obj.allproducts objectAtIndex:[obj.index integerValue]];
        Pimg=[[obj.allproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:0];
    }
    else if([obj.PType isEqualToString:@"PopularProducts"])
    {
        cobj=[obj.popularproducts objectAtIndex:[obj.index integerValue]];
        Pimg=[[obj.popularproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:0];
    }

    else if([obj.PType isEqualToString:@"NewArrivals"])
    {
        cobj=[obj.newarrival objectAtIndex:[obj.index integerValue]];
        Pimg=[[obj.newarrivalImg objectAtIndex:[obj.index integerValue]]objectAtIndex:0];

    }
    if([obj.PType isEqualToString:@"SimilarProducts"])
    {
        cobj=[obj.Similarproducts objectAtIndex:[obj.index integerValue]];
        Pimg=[[obj.Similarproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:0];
    }

}
-(void)AddToWishList
{
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.Pprice :Pimg];
   /* defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ProductsImg,*Products,*ProductDetail;
    
    ProductsImg =[[NSMutableArray alloc] init];
    Products =[[NSMutableArray alloc] init];
    ProductDetail =[[NSMutableArray alloc] init];
    
    [ProductDetail addObject:cobj.PName];
    [ProductDetail addObject:cobj.Pprice];
    [Products addObject:ProductDetail];
    UIImage *contactImage = Pimg;
    NSData *imageData = UIImageJPEGRepresentation(contactImage, 100);
    [ProductsImg addObject:imageData];
    
    NSObject *myobj=[defaults objectForKey:@"Product"];
    NSObject *myImgobj=[defaults objectForKey:@"ProductImg"];
    if(myImgobj == nil){
        
        myProductsImg =[[NSMutableArray alloc] init];
        [myProductsImg  addObject:ProductsImg];
        [defaults setObject:myProductsImg  forKey:@"ProductImg"];
    }
    
   else
    {
        myProductsImg  = [[defaults objectForKey:@"ProductImg"]mutableCopy];
        [myProductsImg   addObject:Products];
        [defaults setObject:myProductsImg   forKey:@"ProductImg"];
    }
    
    if(myobj == nil){
        
        myProducts =[[NSMutableArray alloc] init];
        [myProducts addObject:Products];
        [defaults setObject:myProducts forKey:@"Product"];
    }
    
    else
    {
        myProducts = [[defaults objectForKey:@"Product"]mutableCopy];
        [myProducts  addObject:Products];
        [defaults setObject:myProducts  forKey:@"Product"];
    }

    
    [defaults synchronize];*/

}

@end
