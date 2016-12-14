
//
//  SideMenuViewController.m
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SideMenuViewController.h"
#import <Crashlytics/Crashlytics.h>

static NSString *SideMenuCell =@"SideMenu" , *placeholder=@"PlaceHolder", *refreshview=@"refreshView" , *detailview=@"DetailView" ,*DetailviewCell=@"Detail";
@interface SideMenuViewController ()
{
    MenuData *obj;
}
@end

@implementation SideMenuViewController
@synthesize sidetable;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[MenuData Items];
    [self nav];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:refreshview object:nil];
}

-(void)refreshView:(NSNotification *) notification {
    
    [self.sidetable reloadData];
}

#pragma mark - UITableDelegate Method

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return obj.topmenu.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *deals=[UIStoryboard storyboardWithName:detailview bundle:nil];
    DetailedViewController *dvc = [deals instantiateViewControllerWithIdentifier:DetailviewCell];
    SWRevealViewController *sv=self.revealViewController;
    [sv revealToggle:self];
     
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
    appDelegate.rowindex=[NSNumber numberWithInteger:indexPath.row];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SideMenu *cell = (SideMenu *)[sidetable dequeueReusableCellWithIdentifier:SideMenuCell];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:SideMenuCell owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Categories *currentCat=[obj.topmenu objectAtIndex:indexPath.row];
    NSLog(@"%lu",(unsigned long)obj.topmenu.count);
    cell.NameLabel.text=currentCat.TMtitle;
    
    NSURL *Url = [NSURL URLWithString:currentCat.ImgUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:placeholder];
    
    __weak SideMenu *weakCell = cell;
    
    [cell.Imageview setImageWithURLRequest:request
                                   placeholderImage:placeholderImage
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                weakCell.Imageview.image = image;
                                                [weakCell setNeedsLayout];
                                                
                                            } failure:nil];
    
    return cell;
}

-(void) nav
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView=[[GlobalVariables class]titleView:@"My User" andImg:@"UserIcon" andy:logoY+10];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.sidetable deselectRowAtIndexPath:[self.sidetable indexPathForSelectedRow] animated:NO];
    [self.sidetable setContentOffset:CGPointZero animated:NO];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.sidetable.alwaysBounceVertical=NO;
}

@end
