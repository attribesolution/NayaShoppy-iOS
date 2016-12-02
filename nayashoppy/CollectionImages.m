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
    NSString *imgurl;
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
    NSArray *imgArray;
   if([obj.PType isEqualToString:@"AllProducts"])
   {
       imgArray=[obj.allproductimg objectAtIndex:[obj.index integerValue]];
       
   }
   else if([obj.PType isEqualToString:@"SimilarProducts"])
   {
      imgArray=[obj.Similarproductimg objectAtIndex:[obj.index integerValue]];
      
   }
   else if([obj.PType isEqualToString:@"NewArrivals"])
   {
       imgArray=[obj.newarrivalImg objectAtIndex:[obj.index integerValue]];
   }
   else
   {
        imgArray=[obj.popularproductimg objectAtIndex:[obj.index integerValue]];
   }
    return imgArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ImageCVcell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor clearColor];
//    if([obj.PType isEqualToString:@"AllProducts"])
//    cell.image.image=[[obj.allproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
//    else if([obj.PType isEqualToString:@"SimilarProducts"])
//    cell.image.image=[[obj.Similarproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
//    else if([obj.PType isEqualToString:@"NewArrivals"])
//        cell.image.image=[[obj.newarrivalImg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
//    else
//    cell.image.image=[[obj.popularproductimg  objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    
    cell.backgroundColor=[UIColor clearColor];
    if([obj.PType isEqualToString:@"AllProducts"])
        imgurl=[[obj.allproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else if([obj.PType isEqualToString:@"SimilarProducts"])
        imgurl=[[obj.Similarproductimg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else if([obj.PType isEqualToString:@"NewArrivals"])
        imgurl=[[obj.newarrivalImg objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    else
       imgurl=[[obj.popularproductimg  objectAtIndex:[obj.index integerValue]]objectAtIndex:indexPath.row];
    
    NSURL *Url = [NSURL URLWithString:imgurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak ImageCVcell *weakCell = cell;
    
    [cell.image setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.image.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];

    
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
