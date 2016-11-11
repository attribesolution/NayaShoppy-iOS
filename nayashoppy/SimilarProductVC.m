//
//  SimilarProductVC.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SimilarProductVC.h"

@interface SimilarProductVC ()

@end

@implementation SimilarProductVC
@synthesize SimilarPcollView;

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.SimilarPcollView registerNib:[UINib nibWithNibName:@"SimilarPCVCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SimilarPCVCell"];
    self.SimilarPcollView.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SimilarPCVCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SimilarPCVCell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
    
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/3-1, 109);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.SimilarPcollView.alwaysBounceHorizontal=NO;
}

@end
