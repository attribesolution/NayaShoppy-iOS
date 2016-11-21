//
//  GridListViewController.m
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "GridListViewController.h"
#import "TabledCollectionViewFlowLayout.h"
#import "CollectionCell.h"
#import "TabelledCollectionCell.h"
#import "GridCollectionViewFlowLayout.h"
#import "DGActivityIndicatorView.h"

static NSString *AKCollectionCell = @"CollectionCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";

@interface GridListViewController ()
{
    MenuData *obj;
    DGActivityIndicatorView *activityIndicatorView;
    Categories *cobj;
    UIImage *wishimg;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic)TabledCollectionViewFlowLayout *tLayout;
@property (strong, nonatomic)GridCollectionViewFlowLayout *glayout;
@end

Boolean showInGridView = false;
@implementation GridListViewController
@synthesize Loader,tabindex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obj=[MenuData Items];
  
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Loader.bounds;
    [self.Loader addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    if([tabindex integerValue]==0)
    {
    [mainVC getAllProducts:^(NSArray *respone,NSArray *img) {
        [activityIndicatorView stopAnimating];
        obj.allproductimg=[img copy];
        obj.allproducts=[respone copy];
        self.Loader.hidden=YES;
        [self.collectionView reloadData];
        
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
    }
    else
    {
    [mainVC getPopularProducts:^(NSArray *respone,NSArray *img) {
        
         obj.popularproductimg=[img copy];
         obj.popularproducts=[respone copy];
         self.Loader.hidden=YES;
         [self.collectionView reloadData];
         
        NSLog(@"%@",respone);
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    }

    self.tLayout = [[TabledCollectionViewFlowLayout alloc] init];
    [self.tLayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 200)];
    [self.collectionView setScrollsToTop:YES];
    [self.collectionView registerNib:[UINib nibWithNibName:AKCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKCollectionCell];
     
    self.glayout = [[GridCollectionViewFlowLayout alloc] init];
    [self.glayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 180)];
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void) shuffle
{
    showInGridView = !showInGridView;
    
    if(showInGridView){
        
        [self.collectionView registerNib:[UINib nibWithNibName:AKTabelledCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKTabelledCollectionCell];
        [self.collectionView setCollectionViewLayout:self.glayout animated:YES completion:^(BOOL finished) {
            
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
             [self.collectionView reloadData];
            
        }];
        
        
    }else{
        
        [self.collectionView registerNib:[UINib nibWithNibName:AKCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKCollectionCell];
        
        [self.collectionView setCollectionViewLayout:self.tLayout animated:YES completion:^(BOOL finished) {
            
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:NO];
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
              [self.collectionView reloadData];
            
        }];
    }

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([tabindex integerValue]==0)
        return obj.allproducts.count;
    else
        return obj.popularproducts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([tabindex integerValue]==0)
    cobj=[obj.allproducts objectAtIndex:indexPath.row];
    else
    cobj=[obj.popularproducts objectAtIndex:indexPath.row];
    
    if(showInGridView){
        TabelledCollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:AKTabelledCollectionCell forIndexPath:indexPath];
        
        cell.GridName.text=cobj.PName;
        cell.Company.text=cobj.POfferPrice;
        if([tabindex integerValue]==0)
        wishimg=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        else
        wishimg=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        cell.GridImage.image=wishimg;
        [cell.WishButton addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else{
        CollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:AKCollectionCell forIndexPath:indexPath];
        cell.ListItem.text=cobj.PName;
        cell.LPrice.text=cobj.POfferPrice;
        if([tabindex integerValue]==0)
            wishimg=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        else
            wishimg=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        cell.ListImage.image=wishimg;
        [cell.WishButton addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
   obj.index=[NSNumber numberWithInteger:indexPath.row];
   obj.tabindex=[NSNumber numberWithInteger:0];

   UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
   SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    if([tabindex integerValue]==0)
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

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if(showInGridView)
        cell.backgroundColor = [UIColor whiteColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.frame.size.width,180);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.GLCollectionView.alwaysBounceVertical=NO;
    self.GLCollectionView.alwaysBounceHorizontal=NO;
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
   [ [GlobalVariables class]AddWhishList:cobj.PName :cobj.POfferPrice :wishimg];
}

@end
