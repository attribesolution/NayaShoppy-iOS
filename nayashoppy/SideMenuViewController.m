
//
//  SideMenuViewController.m
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SideMenuViewController.h"
static NSString *SideMenuCell =@"SideMenu";
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
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView=[[GlobalVariables class]titleView:@"My User" andImg:@"user.png" andy:logoY+20];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
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
   // [self performSegueWithIdentifier:@"MSegue" sender:tableView];
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
    cell.Imageview.image=[obj.topmenuImg objectAtIndex:indexPath.row];
    return cell;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.sidetable deselectRowAtIndexPath:[self.sidetable indexPathForSelectedRow] animated:NO];
    [self.sidetable setContentOffset:CGPointZero animated:NO];
}

@end
