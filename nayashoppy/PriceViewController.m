//
//  PriceViewController.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "PriceViewController.h"
#import "ShareUtility.h"
#import "DGActivityIndicatorView.h"
#import "singleton.h"
#import "CollectionImages.h"

static NSString *SimilarProduct=@"SimilarProduct",*ImgNib=@"CollectionImages" ,*imgCell=@"BannerImagesVC",*rcell=@"ReviewCell",*SimPro=@"Sproduct" , *store=@"Stores" ,*specification= @"SpecificationButtonCell" , *specficCell=@"SpecificationCell", *spLabelCell=@"Specification", *storeCell=@"StoreCell" , *imageCell=@"ImageCell" , *detailCell=@"Detail" , *detailnib=@"DetailCell";

@interface PriceViewController ()
{
    NSString *Pimg;
    singleton *obj;
    Categories *cobj;
    ImageCell *imgcell;
    NSMutableArray *supliers;
    DGActivityIndicatorView *activityIndicatorView ;
    BOOL isData;
}

@property(strong,nonatomic) SimilarProductVC *sproduct;
@property (strong, nonatomic) SpecificationListViewController *cvc;
@end

@implementation PriceViewController
@synthesize ToastView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
     obj=[singleton sharedManager];
    supliers=[[NSMutableArray alloc]init];
    [self arrayObject];
    [self Parsedetails];
    [self recentlyViewed];
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Loader.bounds;
    [self.Loader addSubview:activityIndicatorView];
    isData=NO;
    self.Loader.hidden=YES;
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoader:)
                                                 name:@"StopInd" object:nil];
   
}

-(void)removeLoader:(NSNotification *) notification {
    isData=YES;
    [activityIndicatorView stopAnimating];
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
        return supliers.count;
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
    BOOL find;
    find=NO;
    if(indexPath.section==0)
    {
    imgcell = (ImageCell*)[tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        
        self.imgcv.view.frame =imgcell.ImgCollView.bounds;
        [imgcell.ImgCollView addSubview:self.imgcv.view];
        self.imgcv.ProImg=self.ProCatImg;
        imgcell.TitleLabel.text=cobj.PName;
        UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [imgcell.WishIcon setImage:image forState:UIControlStateNormal];
        
        for (int d=0; d<myProducts.count; d++) {
            
            NSString * Name=[[[myProducts objectAtIndex:d]objectAtIndex:0]objectAtIndex:0];
            if ([cobj.PName isEqualToString:Name]) {
                find=YES;
                imgcell.WishIcon.tintColor = [UIColor redColor];
                break;
            }
        }
        if(!find)
            imgcell.WishIcon.tintColor = [UIColor darkGrayColor];
        
       [imgcell.WishIcon addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
        [imgcell.ShareIcon addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
        
        return imgcell;
   }
 
    if (indexPath.section==1)
    {
        DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:detailCell];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:detailnib owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSAttributedString * title =
        [[NSAttributedString alloc] initWithString:[@"Rs " stringByAppendingString:cobj.POfferPrice]
                                        attributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)}];
        [cell.OriginalPriceLabel setAttributedText:title];
        
        cell.priceLabel.textColor=[[GlobalVariables class] themeColor];
        cell.priceLabel.text=[@"Rs " stringByAppendingString:cobj.Pprice];
        cell.DiscountLabel.textColor=[[GlobalVariables class]greenColor];
        if([cobj.Discount isEqualToString:@""] || cobj.Discount==0)
        {
            cell.OriginalPriceLabel.hidden=YES;
            cell.DiscountLabel.text=@"No Discount";
        }
        else
            cell.DiscountLabel.text=[[@"( " stringByAppendingString:cobj.Discount ] stringByAppendingString:@" % OFF)"];
        return cell;
        
    }
    
    
   if (indexPath.section==3) {
        
   
     StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:storeCell];
      if (cell == nil)
      {
         NSArray *nib = [[NSBundle mainBundle] loadNibNamed:storeCell owner:self options:  nil];
         cell = [nib objectAtIndex:0];
       }
      
      Categories *sup=[supliers objectAtIndex:indexPath.row];
      cell.PRICE.text=[@"Rs " stringByAppendingString:sup.StorePrice];
      cell.Description.text=sup.StoreDelivery;
      cell.StoreButton.tag=indexPath.row;
      [cell.StoreButton addTarget:self action:@selector(openURL:) forControlEvents:UIControlEventTouchUpInside];
      return cell;
   
    }
    
    if (indexPath.section==4)
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:spLabelCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:spLabelCell];
        }
        
        return cell;
    }

    if(indexPath.section==5)
    {
        
        SpecificationCell *cell = (SpecificationCell *)[tableView dequeueReusableCellWithIdentifier:specficCell];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:specficCell owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        Categories *sobj=[obj.GernalFeatures objectAtIndex:indexPath.row];
        cell.name.text = sobj.featurename;
        cell.value.text=sobj.featurevalue;
        return cell;
 }
    
    if (indexPath.section==6) {
        
        SpecificationButtonCell *cell = (SpecificationButtonCell *)[tableView dequeueReusableCellWithIdentifier:specification];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:specification owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.SpecificationButton addTarget:self action:@selector(GoToSpecifications:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

       }

    if (indexPath.section==7) {
        
        ReviewCell *cell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:rcell];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:rcell owner:self options:  nil];
            cell = [nib objectAtIndex:0];
        }
        return cell;
    }
    
     if (indexPath.section==8) {
         
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimPro];
         
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimPro];
         }
         
         return cell;
          }
   
    if (indexPath.section==9)
   {
       SimilarProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:SimilarProduct forIndexPath:indexPath];
        self.sproduct.view.frame = cell.SimilarProductView.bounds;
        self.sproduct.XYZDelegate = (SpecificationsViewController * )[self.navigationController topViewController];
       if(!isData)
       {
       [activityIndicatorView startAnimating];
       self.Loader.hidden=NO;
       }
       [cell.SimilarProductView addSubview:self.sproduct.view];
       return cell;
    }
    else
    {
        
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:store];
    
       if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:store];
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
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:SimilarProduct bundle:nil];
    self.sproduct = [coupons instantiateViewControllerWithIdentifier:SimilarProduct];
    UIStoryboard *img=[UIStoryboard storyboardWithName:ImgNib bundle:nil];
    self.imgcv = [img instantiateViewControllerWithIdentifier:imgCell];
    [self addChildViewController:self.imgcv];
    [self.imgcv didMoveToParentViewController:self];
    
       ApiParsing * mainVC = [[ApiParsing alloc] init];
        obj.ProductDetails=nil;
        obj.GernalFeatures=nil;
        [mainVC getDetails:^(NSArray *respone,NSArray *generalFeatures,NSArray *suplier) {
            
            supliers=[suplier copy];
            obj.ProductDetails=[respone copy];
            obj.GernalFeatures=[generalFeatures copy];
            [self.PriceTable reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }];

}

-(void) arrayObject
{
        cobj =self.ProCat;
        Pimg=[self.ProCatImg objectAtIndex:0];
}

-(void)AddToWishList
{
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.Pprice :Pimg: self.ToastView];
    imgcell.WishIcon.tintColor = [UIColor redColor];

}

-(void) recentlyViewed
{
    BOOL Ispresent;
    Ispresent=NO;

    for(int i=0;i<obj.RecentlyViewed.count;i++)
    {
        Categories *rec=[[obj.RecentlyViewed objectAtIndex:i]objectAtIndex:0];
        if([rec.PName isEqualToString:cobj.PName])
        { Ispresent=YES;
            break;
        }
    }
    if(!Ispresent)
    {
        NSMutableArray *proCat=[[NSMutableArray alloc]init];
        [proCat addObject:self.ProCat];
        [proCat addObject:self.ProCatImg];
        [obj.RecentlyViewed addObject:proCat];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
    }
}

-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.PriceTable deselectRowAtIndexPath:[self.PriceTable indexPathForSelectedRow] animated:NO];
    [self.PriceTable setContentOffset:CGPointZero animated:NO];
}

@end
