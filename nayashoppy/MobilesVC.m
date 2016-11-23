



//
//  MobilesVC.m
//  nayashoppy
//
//  Created by Amerald on 22/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "MobilesVC.h"

static NSString *dealsCell = @"DealCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";
@interface MobilesVC ()
{
    MenuData *obj;
    DGActivityIndicatorView *activityInd1,*activityInd2;
    Categories *cobj;
    UIImage *wishimg;
}
@property(copy,nonatomic) NSNumber *tabindex;
@end

@implementation MobilesVC
@synthesize allProduct,PopularProduct,tabindex,PPLoader,AllPLoader;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"slider"] forBarMetrics:UIBarMetricsDefault];
    obj=[MenuData Items];
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
            
            NSLog(@"%@",respone);
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }];
   
    [self.allProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
    [self.PopularProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];
    if(collectionView.tag==100)
    {   cobj=[obj.allproducts objectAtIndex:indexPath.row];
        wishimg=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
    }
    else
    {   cobj=[obj.popularproducts objectAtIndex:indexPath.row];
        wishimg=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
    }
    cell.TitleLabel.text=cobj.PName;
    cell.PriceLabel.text=cobj.Pprice;
        cell.ImageView.image=wishimg;
    [cell.WishButton addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
    return cell;

    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(collectionView.frame.size.width/2-1,250);
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
    [mainVC getDetails:^(NSArray *respone) {
        
        obj.ProductDetails=[respone copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
}

-(void)AddToWishList
{
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.POfferPrice :wishimg: self.view];
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
@end
