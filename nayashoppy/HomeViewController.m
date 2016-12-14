//
//  HomeViewController.m
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuData.h"

static NSString *CouponsCell = @"CouponsCollectionViewCell", *CouponsLabelTitle=@"Coupons & Cashback", *CouponsLabelImg=@"Coupon", *refreshnotif=@"refreshView", *refreshtable=@"refreshTable" ,*imgCell=@"ImageCell", *topmenucell=@"TopMenu", *tableCell=@"TableCell", *newarrivalCell=@"newArrival", *recentCell=@"Recent", *newATitle=@"New Arrivals", *recentVTitle=@"RecentlyViewed", *keyboardNotification=@"HideKeyboard", *couponSB=@"Coupons",*coupCell=@"Cash", *TopMenuSB=@"TopMenuStoryboard", *topMCell=@"TopMenu", *newArrSB=@"NewArrivalsStoryboard", *newarrCell=@"newAv", *recentViewSB=@"RecentStoryboard",*rCell=@"Recent";

@interface HomeViewController ()
{
    MenuData *obj;
    UIImageView *slider;
    DGActivityIndicatorView *activityIndicatorView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[MenuData Items];
    
    [self gesture];
    [self registerCell];
    [self ActivityInd];
    [self notifications];
    /*  ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    [mainVC Slider:^(UIImage *img) {
        
        slider = [[UIImageView alloc] initWithImage:img];
        [self.myTable reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
    */
    
}

-(void)refreshView:(NSNotification *) notification {
    
    [self.myTable reloadData];
    [activityIndicatorView stopAnimating];
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
        return 150;
    if(indexPath.row==7)
        return  109;
    else
      return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(obj.RecentlyViewed.count==0)
        return 6;
    else
        return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row==0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imgCell];
        }
        
        return cell;

    }
    if (indexPath.row==1) {
        
        TopmenuCell *cell = [tableView dequeueReusableCellWithIdentifier:topmenucell forIndexPath:indexPath];
        self.topmenu.view.frame = cell.TopParentView.bounds;
        [cell.TopParentView addSubview:self.topmenu.view];
        return cell;
    }
    if (indexPath.row==3) {
    
       TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCell forIndexPath:indexPath];
        self.collectionCont.view.frame = cell.ParentView.bounds;
        [cell.ParentView addSubview:self.collectionCont.view];
        return cell;
        
    }
    if (indexPath.row==5) {
        
        NewArrivalCell *cell = [tableView dequeueReusableCellWithIdentifier:newarrivalCell forIndexPath:indexPath];
        self.newarrival.view.frame = cell.PnewArrival.bounds;
        [cell.PnewArrival addSubview:self.newarrival.view];
        return cell;
        
    }
    if (indexPath.row==7) {
        
        RecentCell *cell = [tableView dequeueReusableCellWithIdentifier:recentCell forIndexPath:indexPath];
        self.recent.view.frame = cell.Recentview.bounds;
        [cell.Recentview addSubview:self.recent.view];
        return cell;
    }
    else
    {
        TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];

        if(indexPath.row==2)
        [cell.Labelview addSubview:[[GlobalVariables class]titleView:CouponsLabelTitle andImg:CouponsLabelImg ]];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];

        if(indexPath.row==4)
        cell.textLabel.text=newATitle;
        if(indexPath.row==6)
        cell.textLabel.text=recentVTitle;

        return cell;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectedBackgroundView:view];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.myTable.alwaysBounceVertical = NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.myTable deselectRowAtIndexPath:[self.myTable indexPathForSelectedRow] animated:NO];
    [self.myTable setContentOffset:CGPointZero animated:NO];
    
}
-(void) gesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.myTable addGestureRecognizer:tapRecognizer];
       
}
- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyboardNotification object:nil];
    [self.view endEditing:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyboardNotification object:nil];
}

-(void) registerCell
{
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:couponSB bundle:nil];
    self.collectionCont = [coupons instantiateViewControllerWithIdentifier:coupCell];
    
    UIStoryboard *categories=[UIStoryboard storyboardWithName:TopMenuSB bundle:nil];
    self.topmenu = [categories instantiateViewControllerWithIdentifier:topMCell];
    
    UIStoryboard *newarrivals=[UIStoryboard storyboardWithName:newArrSB bundle:nil];
    self.newarrival = [newarrivals instantiateViewControllerWithIdentifier:newarrCell];
    UIStoryboard *recently=[UIStoryboard storyboardWithName:recentViewSB bundle:nil];
    self.recent = [recently instantiateViewControllerWithIdentifier:rCell];

}
-(void) ActivityInd
{
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Loader.bounds;
    [self.Loader addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
}

-(void) notifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:refreshnotif object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:refreshtable object:nil];
}

@end
