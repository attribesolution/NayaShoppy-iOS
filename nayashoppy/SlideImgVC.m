//
//  SlideImgVC.m
//  nayashoppy
//
//  Created by Amerald on 15/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SlideImgVC.h"
#import "SlideImgCell.h"

@interface SlideImgVC ()

@end

@implementation SlideImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.SlideImgCVC registerNib:[UINib nibWithNibName:@"SlideImgCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCell"];
    [self ApiParsing];
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SlideImgCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
  /*  NSURL *Url = [NSURL URLWithString:cobj.ImgUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak SlideImgCell *weakCell = cell;
    
    [cell.NAimg setImageWithURLRequest:request
                      placeholderImage:placeholderImage
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   weakCell.NAimg.image = image;
                                   [weakCell setNeedsLayout];
                                   
                               } failure:nil];*/
    cell.ImageView.image=[UIImage imageNamed:@"slider"];
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, 109);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.SlideImgCVC.alwaysBounceVertical=NO;
}
-(void) ApiParsing
{
    /*  ApiParsing * mainVC = [[ApiParsing alloc] init];
     
     [mainVC Slider:^(UIImage *img) {
     
     slider = [[UIImageView alloc] initWithImage:img];
     [self.myTable reloadData];
     
     } failure:^(NSError *error, NSString *message) {
     NSLog(@"%@",error);
     }];
     */
}

@end
