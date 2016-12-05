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
#import "ShareUtility.h"

static NSString *AKCollectionCell = @"CollectionCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";

@interface GridListViewController ()
{
    MenuData *obj;
    DGActivityIndicatorView *activityIndicatorView;
    Categories *cobj;
    NSString *imgUrl;
    UIImage *wishimg;
    CGFloat Dlines;
    int i;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic)TabledCollectionViewFlowLayout *tLayout;
@property (strong, nonatomic)GridCollectionViewFlowLayout *glayout;
@end

Boolean showInGridView = false;
@implementation GridListViewController
@synthesize Loader,tabindex,FilterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obj=[MenuData Items];
    self.FilterView.hidden=YES;
    [self ApiParsing];
    self.tLayout = [[TabledCollectionViewFlowLayout alloc] init];
    [self.tLayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 180)];
    [self.tLayout setInterItemSpacingY:1.0];
    [self.glayout setInterItemSpacingY:1.0];
    [self.collectionView setScrollsToTop:YES];
    [self.collectionView registerNib:[UINib nibWithNibName:AKCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKCollectionCell];
    
    [self.collectionView registerNib:[UINib nibWithNibName:AKTabelledCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKTabelledCollectionCell];
    
    self.glayout = [[GridCollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:self.tLayout];
   
    
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
        
        CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[cell.GridName font]}];
        CGFloat strikeWidth = textSize.width;
        Dlines=(strikeWidth/cell.GridName.frame.size.width+1)*25+25;
        
        cell.GridName.frame=CGRectMake(cell.GridName.frame.origin.x,cell.GridName.frame.origin.y, cell.GridName.frame.size.width, Dlines);
        
        cell.GridName.text=cobj.PName;
        cell.Company.text=cobj.Pprice;

        if([tabindex integerValue]==0)
            imgUrl=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        else
            imgUrl=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        
        NSURL *Url = [NSURL URLWithString:imgUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:Url];
        UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
        
        __weak TabelledCollectionCell *weakCell = cell;
        
        [cell.GridImage setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.GridImage.image = image;
                                           wishimg=weakCell.GridImage.image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];

        [cell.WishButton addTarget:self action:@selector(AddToWishList)forControlEvents:UIControlEventTouchUpInside];
        [cell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
        [self.glayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 160+Dlines)];
    
        return cell;
    }
    else{
        CollectionCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:AKCollectionCell forIndexPath:indexPath];
        
        CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[cell.ListItem font]}];
        CGFloat strikeWidth = textSize.width;
        Dlines=(strikeWidth/cell.ListItem.frame.size.width+1)*25+25;
        
        cell.ListItem.frame=CGRectMake(cell.ListItem.frame.origin.x,cell.ListItem.frame.origin.y, cell.ListItem.frame.size.width, Dlines);
        
        cell.ListItem.text=cobj.PName;
        cell.LPrice.text=cobj.Pprice;

        if([tabindex integerValue]==0)
            imgUrl=[[obj.allproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        else
            imgUrl=[[obj.popularproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
        
        NSURL *Url = [NSURL URLWithString:imgUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:Url];
        UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
        
        __weak CollectionCell *weakCell = cell;
        
        [cell.ListImage setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.ListImage.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];

     
        [cell.WishButton addTarget:self action:@selector(AddToWishList) forControlEvents:UIControlEventTouchUpInside];
        [cell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
    NSInteger lastSectionIndex = [self.collectionView numberOfSections] - 1;
    NSInteger lastRowIndex = [self.collectionView numberOfItemsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        int pg=[obj.page intValue];
        NSLog(@"%d",pg);
        obj.page=[NSNumber numberWithInt:pg+1];
        NSLog(@"%@",obj.page);
        self.Loader.frame=CGRectMake(self.Loader.frame.origin.x, self.FilterView.frame.origin.y-50, self.Loader.frame.size.width, self.Loader.frame.size.height);
        self.Loader.hidden=NO;
        [self ApiParsing];
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
    [mainVC getDetails:^(NSArray *respone,NSArray *generalFeatures) {
        
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

- (IBAction)FilterButton:(id)sender {
    
    UIStoryboard *deals=[UIStoryboard storyboardWithName:@"GridList" bundle:nil];
    FiltersVC *dvc = [deals instantiateViewControllerWithIdentifier:@"test"];
    [self.navigationController pushViewController:dvc animated:YES];
    
}
-(void) ApiParsing
{
    [self activityInd];
    
   ApiParsing * mainVC = [[ApiParsing alloc] init];
   if([tabindex integerValue]==0)
    {
        [mainVC getAllProducts:^(NSMutableArray *response,NSMutableArray *img) {
            
            i=1;
            [self ReLoadArray:response andvalue:img];

            self.FilterView.hidden=NO;
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }];
        
    }
    else
    {
        [mainVC getPopularProducts:^(NSMutableArray *response,NSMutableArray *img) {
            i=2;
            [self ReLoadArray:response andvalue:img];
            
            self.FilterView.hidden=YES;
            
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }];
    }

}
-(void) ReLoadArray:(NSMutableArray *)response andvalue:(NSMutableArray *)img
{
    if(obj.allproducts.count==0 && i==1)
    {
        obj.allproductimg=[img copy];
        obj.allproducts=[response copy];
    }
    if(obj.popularproducts.count==0 && i==2)
    {
        obj.popularproductimg=[img copy];
        obj.popularproducts=[response copy];
    }
    else{
        
        NSArray *newArray,*newArrayimg;
        newArrayimg=[[NSArray alloc]init];
        newArray=[[NSArray alloc]init];
        if(i==1)
        {
        newArray=[obj.allproductimg arrayByAddingObjectsFromArray:img];
        obj.allproductimg=[newArray copy];
        newArrayimg=[obj.allproducts arrayByAddingObjectsFromArray:response];
        obj.allproducts=[newArrayimg copy];
        }
        else
        {
          newArray=[obj.popularproductimg arrayByAddingObjectsFromArray:img];
          obj.popularproductimg=[newArray copy];
          newArrayimg=[obj.popularproducts arrayByAddingObjectsFromArray:response];
           obj.popularproducts=[newArrayimg copy];
        }
    }
    self.Loader.hidden=YES;
    [activityIndicatorView stopAnimating];
    [self.collectionView reloadData];

}
-(void) activityInd
{
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Loader.bounds;
    [self.Loader addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

}
@end
