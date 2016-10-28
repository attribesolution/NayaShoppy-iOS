//
//  NewArrivalVC.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "NewArrivalVC.h"
static NSString *NewArrivalCell=@"NewArrivalViewCell";
@interface NewArrivalVC ()
{
    MenuData *obj;
}

@end

@implementation NewArrivalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.NewarrivalCv registerNib:[UINib nibWithNibName:NewArrivalCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NewArrivalCell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewArriavlCV:)
                                                 name:@"refreshNewArriavlCV" object:nil];

}
-(void)refreshNewArriavlCV:(NSNotification *) notification{
    
    [self.NewarrivalCv reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return obj.newarrival.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewArrivalViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];
    
    cell.NAimg.image= [obj.newarrivalImg objectAtIndex:indexPath.row];
    [cell.NAProductName setText:[obj.newarrival objectAtIndex:indexPath.row]];
   
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
    self.NewarrivalCv.alwaysBounceVertical=NO;
}


@end
