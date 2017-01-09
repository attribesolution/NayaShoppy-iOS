//
//  UserViewController.m
//  nayashoppy
//
//  Created by Amerald on 24/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "UserViewController.h"
#import "singleton.h"

static NSString *userCell =@"UserCell";

@interface UserViewController ()
{
    NSString *status;
    singleton *obj;
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"SignIn" object:nil];}
-(void) refreshView:(id) sender
{
    status=@"Sign Out";
    [self.UserInfoTable reloadData];
}

#pragma mark - UITableDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        if([status isEqualToString:@"Sign Out"])
        {   status=@"Login/Register";
            [self.UserInfoTable reloadData];
            [[GIDSignIn sharedInstance] signOut];
            [obj.UserReviews removeAllObjects];
        }
        else{
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"SignIn" bundle:nil];
        SignInVC *dvc = [deals instantiateViewControllerWithIdentifier:@"SignIn"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate.navController pushViewController:dvc animated:YES];}
        
     }
    if(indexPath.row==2)
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"Wallet" bundle:nil];
        WalletViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"Wallet"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navController pushViewController:dvc animated:YES];
        
    }
    if(indexPath.row==3)
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"WishList" bundle:nil];
        WalletViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"WishList"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navController pushViewController:dvc animated:YES];
        
    }
    if(indexPath.row==1)
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"Order" bundle:nil];
        OrderViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"Order"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navController pushViewController:dvc animated:YES];
        
    }
    if(indexPath.row==5)
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"AboutUs" bundle:nil];
        AboutUsViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"AboutUs"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navController pushViewController:dvc animated:YES];
        
    }
    if(indexPath.row==4)
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"RateApp" bundle:nil];
        RateAppViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"RateApp"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate.navController pushViewController:dvc animated:YES];
        
    }
  
    SWRevealViewController *sv=self.revealViewController;
    [sv revealToggle:self];
    [sv revealToggle:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UserCell *cell = (UserCell *)[self.UserInfoTable dequeueReusableCellWithIdentifier:userCell];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:userCell owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if(indexPath.row<5)
    {
     if(indexPath.row==0)
     {   if([status isEqualToString:@"Sign Out"])
         cell.Ulabel.text=@"Sign Out";
     else
         cell.Ulabel.text=[[[SideTableData class] UserInfo] objectAtIndex:0][1];
         cell.Uimage.image=[[[SideTableData class] UserInfo] objectAtIndex:0][0];
     }
     else
     {
         cell.Ulabel.text=[[[SideTableData class] UserInfo] objectAtIndex:indexPath.row][1];
         cell.Uimage.image=[[[SideTableData class] UserInfo] objectAtIndex:indexPath.row][0];
     }
    }
    else
     cell.Ulabel.text=[[[SideTableData class] UserInfo] objectAtIndex:indexPath.row][0];
    
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.UserInfoTable deselectRowAtIndexPath:[self.UserInfoTable indexPathForSelectedRow] animated:NO];
    [self.UserInfoTable setContentOffset:CGPointZero animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.UserInfoTable.alwaysBounceVertical = NO;

}

@end
