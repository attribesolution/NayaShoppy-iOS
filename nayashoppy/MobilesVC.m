//
//  MobilesVC.m
//  nayashoppy
//
//  Created by Amerald on 22/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "MobilesVC.h"
#import "ShareUtility.h"
#import "singleton.h"
#import "UIView+UIView_Customize.h"

static NSString *dealsCell = @"DealCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";

@interface MobilesVC ()
{
    singleton *obj;
    DGActivityIndicatorView *activityInd1,*activityInd2;
    NSMutableArray *allproducts,*allproductimg,*popularproductimg,*popularproducts;
    Categories *cobj;
    DealsCell *cell;
    UIImage *wishimg;
    NSString *imgUrl;
    BOOL find;
    int i,tag,pg;

}
@property(copy,nonatomic) NSNumber *tabindex;
@end

@implementation MobilesVC
@synthesize allProduct,PopularProduct,tabindex,PPLoader,AllPLoader,title;

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=[NSNumber numberWithInt:1];
     pg=1;
    [self navbar];
    [self ApiData];
    [self registerCell];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag==100)
    return allproducts.count;
    else
        return popularproducts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];

    if(collectionView.tag==100)
    {   cobj=[allproducts objectAtIndex:indexPath.row];
        imgUrl=[[allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        pg=1;
    }
    else
    {   cobj=[popularproducts objectAtIndex:indexPath.row];
        imgUrl=[[popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        pg=2;
    }

    cell.TitleLabel.text=cobj.PName;
    cell.PriceLabel.text=[@"Rs " stringByAppendingString:cobj.Pprice];
    
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

    UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.WishButton setImage:image forState:UIControlStateNormal];
    
    find=[[UserDefaults class]IsFound:cobj.PName];
    if(!find)
        cell.WishButton.tintColor = [UIColor darkGrayColor];
    else
        cell.WishButton.tintColor = [UIColor redColor];
    
    cell.WishButton.tag=indexPath.row;
    cell.ShareButton.tag=indexPath.row;
    [cell.WishButton addTarget:self action:@selector(AddToWishList:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
    NSInteger lastSectionIndex,lastRowIndex;
    if(collectionView.tag==100)
    {
    lastSectionIndex = [self.allProduct numberOfSections] - 1;
    lastRowIndex = [self.allProduct numberOfItemsInSection:lastSectionIndex] - 1;
        }
    else{
         lastSectionIndex = [self.PopularProduct numberOfSections] - 1;
         lastRowIndex = [self.PopularProduct numberOfItemsInSection:lastSectionIndex] - 1;
    }
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        int page=[_page intValue];
        _page=[NSNumber numberWithInt:page+1];
       if(collectionView.tag==100)
       {
           self.AllPLoader.frame=CGRectMake(self.allProduct.frame.size.width-50, self.AllPLoader.frame.origin.y, self.AllPLoader.frame.size.width, self.AllPLoader.frame.size.height);
           [activityInd1 startAnimating];
           self.AllPLoader.hidden=NO;
           tag=100;
       }
        else
        {
            self.PPLoader.frame=CGRectMake(self.PPLoader.frame.origin.x, self.view.frame.size.height-100, self.PPLoader.frame.size.width, self.PPLoader.frame.size.height);
            tag=200;
            [activityInd2 startAnimating];
            self.PPLoader.hidden=NO;
        }
        pg++;
        [self ApiData];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    if(collectionView.tag==100)
    {
        cobj=[allproducts objectAtIndex:indexPath.row];
        dvc.myobj=[allproducts objectAtIndex:indexPath.row];
        dvc.myobjImg=[[NSMutableArray alloc]initWithArray:[allproductimg objectAtIndex:indexPath.row]];
        
    }
    else
    {
        cobj=[popularproducts objectAtIndex:indexPath.row];
        dvc.myobj =[popularproducts objectAtIndex:indexPath.row];
        dvc.myobjImg =[[NSMutableArray alloc]initWithArray:[popularproductimg objectAtIndex:indexPath.row]];
        
    }
  
    dvc.title=cobj.PName;
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

-(void)AddToWishList:(UIButton *)sender
{
    cobj=[[self loadArray] objectAtIndex:sender.tag];
    [[UserDefaults class]AddWhishList:cobj.PName :cobj.POfferPrice :[self ImgUrl:sender.tag]: self.view];
    cell.WishButton.tintColor = [UIColor redColor];
    [[UserDefaults class]AddWhishList:cobj.PName :cobj.POfferPrice :imgUrl: self.view];
    [self.allProduct reloadData];
    [self.PopularProduct reloadData];
}

-(NSString *) ImgUrl:(NSInteger) ind
{
    if(pg==1)
        return [[allproductimg objectAtIndex:ind]objectAtIndex:0];
    else
        return [[popularproductimg objectAtIndex:ind]objectAtIndex:0];
}

-(NSMutableArray *) loadArray
{
    if(pg==1)
        return allproducts;
    else
        return popularproducts;
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

     CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
     [self.navigationItem setTitleView:[UIView titleView:self.title andImg:@"Logo" andy:logoY]];
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
     self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
}

-(void) ApiData
{
    if([self.page integerValue]==1)
    [self activityIndicator];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    if(tag==100 || allproducts.count==0)
    {
    [mainVC getAllProducts:^(NSArray *respone,NSArray *img) {
        
         i=1;
       [self ReLoadArray:respone andvalue:img];
        self.AllPLoader.hidden=YES;
        [activityInd1 stopAnimating];
        [self.allProduct reloadData];
        
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }
     catId:_catId branchId:_branchId page:_page
     ];
    }
    if(tag==200 || popularproducts.count==0)
    {
    [mainVC getPopularProducts:^(NSArray *respone,NSArray *img) {
        
        i=2;
        [self ReLoadArray:respone andvalue:img];
        self.PPLoader.hidden=YES;
        [activityInd2 stopAnimating];
        [self.PopularProduct reloadData];
        
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }
     catId:_catId branchId:_branchId page:_page
     ];
    }
}
-(void) ReLoadArray:(NSArray *)response andvalue:(NSArray *)img
{
    if(allproducts.count==0 && i==1)
    {
        allproductimg=[img copy];
        allproducts=[response copy];
    }
    else if(popularproducts.count==0 && i==2)
    {
        popularproductimg=[img copy];
        popularproducts=[response copy];
    }
    else{
        
        NSArray *newArray,*newArrayimg;
        newArrayimg=[[NSArray alloc]init];
        newArray=[[NSArray alloc]init];
        if(i==1)
        {
            newArray=[allproductimg arrayByAddingObjectsFromArray:img];
            allproductimg=[newArray copy];
            newArrayimg=[allproducts arrayByAddingObjectsFromArray:response];
            allproducts=[newArrayimg copy];
        }
        else
        {
            newArray=[popularproductimg arrayByAddingObjectsFromArray:img];
            popularproductimg=[newArray copy];
            newArrayimg=[popularproducts arrayByAddingObjectsFromArray:response];
            popularproducts=[newArrayimg copy];
        }
    }
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

-(void) registerCell
{
    [self.allProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
    [self.PopularProduct registerNib:[UINib nibWithNibName:@"DealsCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}
@end
