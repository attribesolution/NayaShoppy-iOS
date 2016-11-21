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
    self.NewarrivalCv.backgroundColor=[UIColor groupTableViewBackgroundColor];
}
-(void)refreshNewArriavlCV:(NSNotification *) notification{
    
    [self.NewarrivalCv reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return obj.newarrival.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    obj.index=[NSNumber numberWithInteger:indexPath.row];
    Categories *cobj=[obj.newarrival objectAtIndex:indexPath.row];
    obj.PType=@"NewArrivals";
    obj.PCatId=cobj.PcatId;
    obj.PPrice=cobj.Pprice;
    obj.slug=cobj.Pslug;
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    SWRevealViewController *sv=self.revealViewController;
    [sv revealToggle:self];
    dvc.title=cobj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
     
    
 
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Categories *cobj=[obj.newarrival objectAtIndex:indexPath.row];
    NewArrivalViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];
    
    cell.NAimg.image= [[obj.newarrivalImg objectAtIndex:indexPath.row]objectAtIndex:0];
    [cell.NAProductName setText:cobj.PName];
   
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
