
//
//  CouponsVC.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CouponsVC.h"

static NSString *CouponsCell = @"CouponsCollectionViewCell";

@interface CouponsVC ()

@end

@implementation CouponsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cashCV setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.cashCV registerNib:[UINib nibWithNibName:CouponsCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CouponsCell];
    self.cashCV.backgroundColor=[UIColor whiteColor];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.cashCV.collectionViewLayout invalidateLayout];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponsCollectionViewCell *CCcell = [collectionView dequeueReusableCellWithReuseIdentifier:CouponsCell forIndexPath:indexPath];
    CCcell.CouponLabel.text= [[CashAndCouponsData class] CashCoupons][indexPath.row][0];
    CCcell.backgroundColor=[[CashAndCouponsData class] CashCoupons][indexPath.row][1];
    return CCcell;
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); 
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((collectionView.frame.size.width/5),70);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.cashCV.alwaysBounceVertical=NO;
}



@end
