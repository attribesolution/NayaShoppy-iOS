//
//  DealsOfTheDayViewController.m
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "DealsOfTheDayViewController.h"
static NSString *dealsCell = @"DealsCell";
@interface DealsOfTheDayViewController ()
{
    MenuData *ob;
}
@end

@implementation DealsOfTheDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ob=[MenuData Items];
   // if(ob.DealsOfTheDay.count==0)
      }
-(void)refreshDealsCV:(NSNotification *) notification{
    
    [self.DealsOfTheDayCV reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.DealsOfTheDayCV registerNib:[UINib nibWithNibName:dealsCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return ob.DealsOfTheDay.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
       DealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];
        Categories *obj=[ob.DealsOfTheDay objectAtIndex:indexPath.row];
        cell.ImageView.image=[ob.DealsOfTheDayImg objectAtIndex:indexPath.row];
        cell.TitleLabel.text=obj.TMtitle;
        cell.PriceLabel.text=[[obj.OfferPrice stringByAppendingString:@"  " ]stringByAppendingString:obj.ActualPrice];
        return cell;   
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(collectionView.frame.size.width/2-1, collectionView.frame.size.height/3-2);
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.DealsOfTheDayCV.alwaysBounceVertical = NO;
}

    


@end
