//
//  RecetVC.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "RecetVC.h"
static NSString *NewArrivalCell=@"NewArrivalViewCell";

@interface RecetVC ()

@end

@implementation RecetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recentvc registerNib:[UINib nibWithNibName:NewArrivalCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NewArrivalCell];
    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewArrivalViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    cell.NAimg.image= [obj.newarrivalImg objectAtIndex:indexPath.row];
//    [cell.NAProductName setText:[obj.newarrival objectAtIndex:indexPath.row]];
    
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
    self.recentvc.alwaysBounceVertical=NO;
}


@end
