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
}
@end

@implementation SimilarProductVC
@synthesize SimilarPcollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
}

-(void)viewWillAppear:(BOOL)animated{
    
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

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarPCVCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SimilarPCVCell" forIndexPath:indexPath];
    Categories *cobj=[obj.Similarproducts objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    cell.Image.image=[obj.Similarproductimg objectAtIndex:indexPath.row];
    cell.Title.text=cobj.TMtitle;
    cell.Company.text=cobj.OfferPrice;
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

@end
