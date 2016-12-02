//
//  SimilarProductVC.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SimilarProductVC.h"

@interface SimilarProductVC ()
{
    MenuData *obj;
    Categories *cobj;
}
@end

@implementation SimilarProductVC
@synthesize SimilarPcollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
}

-(void)viewWillAppear:(BOOL)animated{
    
    obj.Similarproductimg=nil;
    obj.Similarproducts=nil;
    [super viewWillAppear:animated];
    [self.SimilarPcollView registerNib:[UINib nibWithNibName:@"SimilarPCVCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SimilarPCVCell"];
    self.SimilarPcollView.backgroundColor=[UIColor clearColor];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    [mainVC getSimilarProducts:^(NSArray *respone,NSArray *img) {
        
        obj.Similarproductimg=[img copy];
        obj.Similarproducts=[respone copy];
        [self.SimilarPcollView reloadData];
        
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
    obj.PType=@"SimilarProducts";
    obj.PCatId=cobj.PcatId;
    obj.PPrice=cobj.Pprice;
    obj.slug=cobj.Pslug;
    [self ParseData];
    if([self.XYZDelegate respondsToSelector:@selector(ReloadView)])
        [self.XYZDelegate ReloadView];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarPCVCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SimilarPCVCell" forIndexPath:indexPath];
    cobj=[obj.Similarproducts objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
   // cell.Image.image=[[obj.Similarproductimg objectAtIndex:indexPath.row]objectAtIndex:0];
    NSURL *Url = [NSURL URLWithString:[[obj.Similarproductimg objectAtIndex:indexPath.row]objectAtIndex:0]];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak SimilarPCVCell *weakCell = cell;
    
    [cell.Image setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.Image.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
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
    return CGSizeMake(collectionView.frame.size.width/3-1, 180);
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    
}

@end
