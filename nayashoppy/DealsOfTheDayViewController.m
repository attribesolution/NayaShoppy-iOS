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
    /* if(ob.DealsOfTheDay.count==0)
       self.myView.hidden=NO;
     else*/
    self.myView.hidden=YES;
    //  self.DealsOfTheDayCV.backgroundColor=[UIColor whiteColor];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDealsCV:)
                                                 name:@"refreshDealsCV" object:nil];
      }

-(void)refreshDealsCV:(NSNotification *) notification{
    
    [self.DealsOfTheDayCV reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.DealsOfTheDayCV registerNib:[UINib nibWithNibName:dealsCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return ob.newarrival.count;// ob.DealsOfTheDay.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ob.index=[NSNumber numberWithInteger:indexPath.row];
    Categories *cobj=[ob.newarrival objectAtIndex:indexPath.row];
    ob.PType=@"NewArrivals";
    ob.PCatId=cobj.PcatId;
    ob.PPrice=cobj.Pprice;
    ob.slug=cobj.Pslug;
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    dvc.title=cobj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Categories *cobj=[ob.newarrival objectAtIndex:indexPath.row];
       DealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];
   /*  Categories *obj=[ob.DealsOfTheDay objectAtIndex:indexPath.row];
        cell.ImageView.image=[ob.DealsOfTheDayImg objectAtIndex:indexPath.row];
        cell.TitleLabel.text=obj.TMtitle;
        cell.PriceLabel.text=[[obj.OfferPrice stringByAppendingString:@"  "]stringByAppendingString:obj.ActualPrice];*/
    cell.ImageView.image=[[ob.newarrivalImg objectAtIndex:indexPath.row]objectAtIndex:0];
    cell.TitleLabel.text=cobj.PName;
    cell.PriceLabel.text=cobj.Pprice;
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
