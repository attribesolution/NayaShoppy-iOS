//
//  SimilarProductVC.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SimilarProductVC.h"
#import "ShareUtility.h"
#import "singleton.h"

static NSString *similarPCell=@"SimilarPCVCell", *similarProduct=@"SimilarProducts" ,*placeHolderImg=@"PlaceHolder",*wishIcon=@"WishIcon" ,*notification=@"refreshTable";

@interface SimilarProductVC ()
{
    singleton *obj;
    Categories *cobj;
    NSString *imgUrl;
    SimilarPCVCell *cell;
}
@end

@implementation SimilarProductVC
@synthesize SimilarPcollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    obj.Similarproductimg=nil;
    obj.Similarproducts=nil;
    [super viewWillAppear:animated];
    [self.SimilarPcollView registerNib:[UINib nibWithNibName:similarPCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:similarPCell];
    self.SimilarPcollView.backgroundColor=[UIColor clearColor];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    [mainVC getSimilarProducts:^(NSArray *respone,NSArray *img) {
        
        obj.Similarproductimg=[img copy];
        obj.Similarproducts=[respone copy];
        [self.SimilarPcollView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StopInd" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return obj.Similarproducts.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    obj.index=[NSNumber numberWithInteger:indexPath.row];
    cobj=[obj.Similarproducts objectAtIndex:indexPath.row];
    obj.PType=similarProduct;
    obj.PCatId=cobj.PcatId;
    obj.PPrice=cobj.Pprice;
    obj.slug=cobj.Pslug;
    [self ParseData];
    if([self.XYZDelegate respondsToSelector:@selector(ReloadView)])
        [self.XYZDelegate ReloadView];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL find=NO;
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:similarPCell forIndexPath:indexPath];
    cobj=[obj.Similarproducts objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];

    NSURL *Url = [NSURL URLWithString:[[obj.Similarproductimg objectAtIndex:indexPath.row]objectAtIndex:0]];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:placeHolderImg];
    
    __weak SimilarPCVCell *weakCell = cell;
    
    [cell.Image setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.Image.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
    UIImage *image = [[UIImage imageNamed:wishIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.WishIcon setImage:image forState:UIControlStateNormal];
    for (int d=0; d<myProducts.count; d++) {
        
        NSString * Name=[[[myProducts objectAtIndex:d]objectAtIndex:0]objectAtIndex:0];
        if ([cobj.PName isEqualToString:Name]) {
            find=YES;
            cell.WishIcon.tintColor = [UIColor redColor];
            break;
        }
    }
    if(!find)
        cell.WishIcon.tintColor = [UIColor darkGrayColor];
    
    cell.WishIcon.tag=indexPath.row;
    cell.ShareIcon.tag=indexPath.row;
    [cell.WishIcon addTarget:self action:@selector(AddToWishList:)forControlEvents:UIControlEventTouchUpInside];
    [cell.ShareIcon addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];

    cell.Title.text=cobj.PName;
    cell.Company.text=cobj.POfferPrice;
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2-1, 180);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.SimilarPcollView.alwaysBounceHorizontal=NO;
}
-(void) ParseData
{
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    obj.ProductDetails=nil;
    obj.GernalFeatures=nil;
    [mainVC getDetails:^(NSArray *respone,NSArray *generalFeatures) {
        
        obj.ProductDetails=[respone copy];
        obj.GernalFeatures=[generalFeatures copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
}

-(void)AddToWishList:(UIButton *) sender
{   cobj=[obj.Similarproducts objectAtIndex:sender.tag];
    imgUrl=[[obj.Similarproductimg objectAtIndex:sender.tag]objectAtIndex:0];
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.POfferPrice :imgUrl: self.view];
    cell.WishIcon.tintColor = [UIColor redColor];
     [self.SimilarPcollView reloadData];
}

-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}

@end
