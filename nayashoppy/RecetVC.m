//
//  RecetVC.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "RecetVC.h"
#import "Categories.h"
#import "SpecificationsViewController.h"
#import "AppDelegate.h"
#import "singleton.h"

static NSString *NewArrivalCell=@"NewArrivalViewCell";

@interface RecetVC ()
{
    singleton *obj;
    Categories *cobj;
}
@end

@implementation RecetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
    [self.recentvc registerNib:[UINib nibWithNibName:NewArrivalCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NewArrivalCell];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)                                                                                                                                                                                        name:@"refreshTable" object:nil];
}

-(void)refreshView:(NSNotification *) notification {
    
    [self.recentvc reloadData];
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return obj.RecentlyViewed.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *robj=[[obj.RecentlyViewed objectAtIndex:indexPath.row]objectAtIndex:0];
    obj.PCatId=robj.PcatId;
    obj.PPrice=robj.Pprice;
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    dvc.myobj=robj;
    dvc.slug=robj.Pslug;
    dvc.myobjImg=[[obj.RecentlyViewed objectAtIndex:indexPath.row]objectAtIndex:1];
    SWRevealViewController *sv=self.revealViewController;
    [sv revealToggle:self];
    dvc.title=robj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    cobj=[[obj.RecentlyViewed objectAtIndex:indexPath.row]objectAtIndex:0];
    NewArrivalViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];

    NSURL *Url = [NSURL URLWithString:[[[obj.RecentlyViewed objectAtIndex:indexPath.row]objectAtIndex:1]objectAtIndex:0]];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak NewArrivalViewCell *weakCell = cell;
    
    [cell.NAimg setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.NAimg.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];

    cell.NAProductName.text=cobj.PName;
    cell.Price.hidden=YES;
    cell.Company.hidden=YES;
    
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2-1, 109);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.recentvc.alwaysBounceVertical=NO;
}


@end
