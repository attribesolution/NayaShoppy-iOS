
//
//  TopMenuVc.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "TopMenuVc.h"
static NSString *CategoriesVCell = @"CategoriesCell";
@interface TopMenuVc ()
{
    MenuData *obj;
}
@end

@implementation TopMenuVc

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.TopmenuVC registerNib:[UINib nibWithNibName:CategoriesVCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CategoriesVCell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshView" object:nil];
    self.TopmenuVC.backgroundColor=[UIColor groupTableViewBackgroundColor];
}
-(void)refreshView:(NSNotification *) notification {
    
    [self.TopmenuVC reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return obj.topmenu.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    UIStoryboard *deals=[UIStoryboard storyboardWithName:@"DetailView" bundle:nil];
    DetailedViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"Detail"];
    SWRevealViewController *sv=self.revealViewController;
     [sv revealToggle:self];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    CategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoriesVCell forIndexPath:indexPath];
    
    Categories *ob=[obj.topmenu objectAtIndex:indexPath.row];
    
    cell.thumbnailImageView.image=[obj.topmenuImg objectAtIndex:indexPath.row];
    [cell.customLabel setText:ob.TMtitle];
           return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/4-1,90);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     self.TopmenuVC.alwaysBounceVertical=NO;
}
@end
