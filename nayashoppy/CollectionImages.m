//

//  CollectionImages.m
//  nayashoppy
//
//  Created by Amerald on 14/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CollectionImages.h"
#import "singleton.h"

static NSString *allproduct=@"AllProducts", *SimilarProduct=@"SimilarProducts",*newArrivals=@"NewArrivals",*cellId=@"ImageCell",*cellNib=@"ImageCVcell", *PlaceHolderImg=@"PlaceHolder";

@interface CollectionImages ()
{
    singleton *obj;
    NSString *imgurl;
}
@end

@implementation CollectionImages

- (void)viewDidLoad {
    [super viewDidLoad];
    
    obj=[singleton sharedManager];
    [self.ImgCView registerNib:[UINib nibWithNibName:cellNib bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
   
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.ProImg.count;
  
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ImageCVcell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor clearColor];
   
    imgurl=[self.ProImg objectAtIndex:indexPath.row];
 
    NSURL *Url = [NSURL URLWithString:imgurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:PlaceHolderImg];
    
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
