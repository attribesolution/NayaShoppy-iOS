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
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.cashCV registerNib:[UINib nibWithNibName:CouponsCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CouponsCell];
    self.cashCV.backgroundColor=[UIColor groupTableViewBackgroundColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CouponsCollectionViewCell *CCcell = [collectionView dequeueReusableCellWithReuseIdentifier:CouponsCell forIndexPath:indexPath];
    CCcell.CouponLabel.text=[[GlobalVariables class] CashCoupons][indexPath.row][0];
    CCcell.backgroundColor=[[GlobalVariables class] CashCoupons][indexPath.row][1];
    return CCcell;
    
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/5-1, 70);
}


@end
