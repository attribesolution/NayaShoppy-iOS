//
//  CategoriesViewController.m
//  nayashoppy
//
//  Created by Amerald on 17/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CategoriesViewController.h"
static NSString *CouponsCell = @"CouponsCollectionViewCell";
static NSString *CategoriesVCell=@"CategoriesCell";
static NSString *CouponsLabelTitle=@"Coupons & Cashback";
static NSString *CouponsLabelImg=@"coupon.png";
static NSString *NewArrivalCell=@"NewArrivalViewCell";

@interface CategoriesViewController ()
{
    MenuData *ob;
    UITapGestureRecognizer *tapRecognizer;
    
}
@end

@implementation CategoriesViewController
@synthesize couponsLabel,ScrollView,NewArrivalCv;

@synthesize myCollectionView;

-(void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.ScrollView layoutIfNeeded];
    self.ScrollView.contentSize=self.Contentview.bounds.size;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    ob=[MenuData Items];
    [DejalActivityView activityViewForView:self.LoadingView withLabel:LoadingText width:self.LoadingView.frame.size.width-self.LoadingView.frame.size.width/2];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:topmenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewArriavlCV:)
                                                 name:topmenuNotification object:nil];
    
    [couponsLabel addSubview:[[GlobalVariables class]titleView:CouponsLabelTitle andImg:CouponsLabelImg
                              ]];
    ScrollView.contentSize = CGSizeMake(ScrollView.frame.size.width, self.view.frame.size.height);
    NewArrivalCv.backgroundColor=[UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem.enabled=NO;
}

-(void)refreshView:(NSNotification *) notification {
    
    [self.myCollectionView reloadData];
    [self.coupons reloadData];
    [DejalActivityView removeView];
    self.LoadingView.hidden=YES;
    self.navigationItem.leftBarButtonItem.enabled=YES;
}
-(void)refreshNewArriavlCV:(NSNotification *) notification{

    [self.NewArrivalCv reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:CategoriesVCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CategoriesVCell];
    [self.coupons registerNib:[UINib nibWithNibName:CouponsCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CouponsCell];
    [self.NewArrivalCv registerNib:[UINib nibWithNibName:NewArrivalCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NewArrivalCell];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView==self.myCollectionView)
        return ob.topmenu.count;
    if(collectionView==self.NewArrivalCv)
        return ob.newarrival.count;
    else
        return 5;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag==1) {
    CategoriesCell *Ccell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoriesVCell forIndexPath:indexPath];
    
    Categories *obj=[ob.topmenu objectAtIndex:indexPath.row];
        
    Ccell.thumbnailImageView.image= [ob.topmenuImg objectAtIndex:indexPath.row];
    [Ccell.customLabel setText:obj.TMtitle];
        return Ccell;
    }
    
    if (collectionView.tag==2) {
    NewArrivalViewCell *NAcell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];
        
        NAcell.NAimg.image= [ob.newarrivalImg objectAtIndex:indexPath.row];
        [NAcell.NAProductName setText:[ob.newarrival objectAtIndex:indexPath.row]];

        return NAcell;
    }
    else
    {
        CouponsCollectionViewCell *CCcell = [collectionView dequeueReusableCellWithReuseIdentifier:CouponsCell forIndexPath:indexPath];
        CCcell.CouponLabel.text=[[GlobalVariables class] CashCoupons][indexPath.row][0];
        CCcell.backgroundColor=[[GlobalVariables class] CashCoupons][indexPath.row][1];
        return CCcell;
    }
 
   
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView==self.myCollectionView)
    return CGSizeMake(collectionView.frame.size.width/4-1, 90);
    if(collectionView==self.NewArrivalCv)
        return CGSizeMake(collectionView.frame.size.width/3-1, 109);
    else
        return CGSizeMake(collectionView.frame.size.width/5-1, 70);
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.ScrollView.alwaysBounceVertical = NO;
    self.myCollectionView.alwaysBounceVertical=NO;
    self.NewArrivalCv.alwaysBounceHorizontal = NO;
    
  
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  
}
@end
