



//
//  MobilesVC.m
//  nayashoppy
//
//  Created by Amerald on 22/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "MobilesVC.h"
#import "ShareUtility.h"

static NSString *dealsCell = @"DealCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";

@interface MobilesVC ()
{
    MenuData *obj;
    DGActivityIndicatorView *activityInd1,*activityInd2;
    Categories *cobj;
    UIImage *wishimg;
    NSString *imgUrl;

}
@property(copy,nonatomic) NSNumber *tabindex;
@end

@implementation MobilesVC
@synthesize allProduct,PopularProduct,tabindex,PPLoader,AllPLoader,title;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navbar];
    [self ApiData];
    [self registerCell];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag==100)
    return obj.allproducts.count;
    else
        return obj.popularproducts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];

    if(collectionView.tag==100)
    {   cobj=[obj.allproducts objectAtIndex:indexPath.row];
        imgUrl=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
    }
    else
    {   cobj=[obj.popularproducts objectAtIndex:indexPath.row];
        imgUrl=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
    }

    cell.TitleLabel.text=cobj.PName;
    cell.PriceLabel.text=cobj.Pprice;
    
    NSURL *Url = [NSURL URLWithString:imgUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak DealsCell *weakCell = cell;
    
    [cell.ImageView setImageWithURLRequest:request
                                   placeholderImage:placeholderImage
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                weakCell.ImageView.image = image;
                                                wishimg=weakCell.ImageView.image;
                                                [weakCell setNeedsLayout];
                                                
                                            } failure:nil];

    [cell.WishButton addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
    [cell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    obj.index=[NSNumber numberWithInteger:indexPath.row];
    obj.tabindex=[NSNumber numberWithInteger:0];
    
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    if(collectionView.tag==100)
    {
        cobj=[obj.allproducts objectAtIndex:indexPath.row];
        obj.PType=@"AllProducts";
    }
    else
    {
        cobj=[obj.popularproducts objectAtIndex:indexPath.row];
        obj.PType=@"PopularProducts";
    }
    dvc.title=cobj.PName;
    obj.PCatId=cobj.PcatId;
    obj.PPrice=cobj.Pprice;
    obj.slug=cobj.Pslug;
    [self ParseData];
    [self.navigationController pushViewController:dvc animated:YES];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(collectionView.frame.size.width/2-1,180);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.allProduct.alwaysBounceHorizontal=NO;
    self.PopularProduct.alwaysBounceVertical=NO;
}

-(void) ParseData
{
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    obj.ProductDetails=nil;
    obj.GernalFeatures=nil;
    [mainVC getDetails:^(NSArray *respone, NSArray *generalFeatures) {
        
        obj.ProductDetails=[respone copy];
        obj.GernalFeatures=[generalFeatures copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
}

-(void)AddToWishList
{
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.POfferPrice :imgUrl: self.view];
}
-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}
-(void)activityIndicator
{
     activityInd1 = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
     activityInd1.frame = self.AllPLoader.bounds;
     activityInd2 = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
     activityInd2.frame = self.PPLoader.bounds;
     [self.AllPLoader addSubview:activityInd1];
     [self.PPLoader addSubview:activityInd2];
     [activityInd1 startAnimating];
     [activityInd2 startAnimating];
}

-(void) navbar
{
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBarBg"] forBarMetrics:UIBarMetricsDefault];
     [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,self.navigationController.navigationBar.frame.size.height+30)];

     CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
     self.navigationItem.titleView =[[GlobalVariables class] titleView:self.title andImg:@"Logo" andy:logoY] ;
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
     self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

-(void) ApiData
{
    obj=[MenuData Items];
    obj.page=[NSNumber numberWithInt:1];
    [self activityIndicator];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    [mainVC getAllProducts:^(NSArray *respone,NSArray *img) {
        
        [activityInd1 stopAnimating];
        obj.allproductimg=[img copy];
        obj.allproducts=[respone copy];
        self.AllPLoader.hidden=YES;
        [self.allProduct reloadData];
        
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
    [mainVC getPopularProducts:^(NSArray *respone,NSArray *img) {
        
        [activityInd2 stopAnimating];
        obj.popularproductimg=[img copy];
        obj.popularproducts=[respone copy];
        self.PPLoader.hidden=YES;
        [self.PopularProduct reloadData];
        
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];

}
-(void) registerCell
{
    [self.allProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
    [self.PopularProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}
@end
