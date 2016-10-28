//
//  HomeViewController.m
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "HomeViewController.h"
static NSString *CouponsCell = @"CouponsCollectionViewCell";
static NSString *CouponsLabelTitle=@"Coupons & Cashback";
static NSString *CouponsLabelImg=@"Coupon";

@interface HomeViewController ()
{
    UIImageView *slider;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"Coupons" bundle:nil];
    self.collectionCont = [coupons instantiateViewControllerWithIdentifier:@"Cash"];
    
    UIStoryboard *categories=[UIStoryboard storyboardWithName:@"TopMenuStoryboard" bundle:nil];
    self.topmenu = [categories instantiateViewControllerWithIdentifier:@"TopMenu"];
    
    UIStoryboard *newarrivals=[UIStoryboard storyboardWithName:@"NewArrivalsStoryboard" bundle:nil];
    self.newarrival = [newarrivals instantiateViewControllerWithIdentifier:@"newAv"];
    UIStoryboard *recently=[UIStoryboard storyboardWithName:@"RecentStoryboard" bundle:nil];
    self.recent = [recently instantiateViewControllerWithIdentifier:@"Recent"];
    [DejalActivityView activityViewForView:self.LoadingView withLabel:@"Loading Data..." width:self.view.frame.size.width-self.view.frame.size.width/2];
    
     /*  ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    [mainVC Slider:^(UIImage *img) {
        
        slider = [[UIImageView alloc] initWithImage:img];
        [self.myTable reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshView" object:nil];
}
-(void)refreshView:(NSNotification *) notification {
    
    [self.myTable reloadData];
    [DejalActivityView removeView];
    self.LoadingView.hidden=YES;
}

#pragma mark - UITableDelegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.row==0)
        return  80;
    if(indexPath.row==1)
      return  183;
    if(indexPath.row==3)
       return 90;
    if(indexPath.row==5)
        return 109;
    if(indexPath.row==7)
        return  109;
    else
      return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row==0)
    {
        static NSString *simpleTableIdentifier = @"ImageCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        //cell.imageView.image=[UIImage imageNamed:@"UserIcon"];
        
        return cell;

    }
    if (indexPath.row==1) {
        
        TopmenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopMenu" forIndexPath:indexPath];
        self.topmenu.view.frame = cell.TopParentView.bounds;
        [cell.TopParentView addSubview:self.topmenu.view];
        return cell;
    }
    if (indexPath.row==3) {
    
       TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        self.collectionCont.view.frame = cell.ParentView.bounds;
        [cell.ParentView addSubview:self.collectionCont.view];
        return cell;
        
    }
    if (indexPath.row==5) {
        
        NewArrivalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newArrival" forIndexPath:indexPath];
        self.newarrival.view.frame = cell.PnewArrival.bounds;
        [cell.PnewArrival addSubview:self.newarrival.view];
        return cell;
        
    }
    if (indexPath.row==7) {
        
        RecentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Recent" forIndexPath:indexPath];
        self.recent.view.frame = cell.Recentview.bounds;
        [cell.Recentview addSubview:self.recent.view];
        return cell;
    }
    else
    {
        TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];

        if(indexPath.row==2)
        [cell.Labelview addSubview:[[GlobalVariables class]titleView:CouponsLabelTitle andImg:CouponsLabelImg ]];
        if(indexPath.row==4)
        cell.textLabel.text= @"New Arrivals";
        if(indexPath.row==6)
        cell.textLabel.text= @"RecentlyViewed";

        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myTable.alwaysBounceVertical = NO;
}

@end
