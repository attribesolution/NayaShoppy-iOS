//

//  CollectionImages.m
//  nayashoppy
//
//  Created by Amerald on 14/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CollectionImages.h"

@interface CollectionImages ()
{
    MenuData *obj;
}
@end

@implementation CollectionImages

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obj=[MenuData Items];
    [self.ImgCView registerNib:[UINib nibWithNibName:@"ImageCVcell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCell"];
   
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   if([obj.PType isEqualToString:@"AllProducts"])
    return [[obj.allproductimg objectAtIndex:[obj.index integerValue]]count];
    
   else if([obj.PType isEqualToString:@"SimilarProducts"])
        return [[obj.Similarproductimg objectAtIndex:[obj.index integerValue]]count];
    
   else if([obj.PType isEqualToString:@"NewArrivals"])
       return [[obj.newarrivalImg objectAtIndex:[obj.index integerValue]]count];
   else
        return [[obj.popularproductimg objectAtIndex:[obj.index integerValue]]count];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ImageCVcell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    if([obj.PType isEqualToString:@"AllProducts"])
    cell.image.image=[[obj.allproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else if([obj.PType isEqualToString:@"SimilarProducts"])
    cell.image.image=[[obj.Similarproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else if([obj.PType isEqualToString:@"NewArrivals"])
        cell.image.image=[[obj.newarrivalImg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else
    cell.image.image=[[obj.popularproductimg  objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 102);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.ImgCView.alwaysBounceHorizontal=NO;
}


@end
