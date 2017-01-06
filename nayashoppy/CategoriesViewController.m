//
//  CategoriesViewController.m
//  nayashoppy
//
//  Created by Amerald on 31/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CategoriesViewController.h"
#import "Categories.h"
#import "ProductViewController.h"
#import "singleton.h"

@interface CategoriesViewController ()
{
    singleton *obj;
    NSMutableArray *catid;
    Categories *currentCat;
    CGFloat tableY;
}
@property (nonatomic, strong) NSArray *contents;
@end

@implementation CategoriesViewController
@synthesize myTable;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[singleton sharedManager];
    self.myTable.SKSTableViewDelegate = self;
     self.navigationController.navigationItem.backBarButtonItem.title = @" ";
}

#pragma mark - UITableViewDelegate

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (NSArray *)contents
{
    
    if (!_contents )
    {
       for (int i=0; i<obj.topmenu.count; i++) {
           
       currentCat=[obj.topmenu objectAtIndex:i];
      
        if([self.catName isEqualToString:currentCat.TMtitle])
        {
        _contents = @[currentCat.TMCat];
            break;
        }
       }
    }
     else {
        
        
    }
    
    return _contents;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.contents count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * temp = self.contents[section];
    return  temp.count;
    
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * temp = self.contents[indexPath.section];
    temp = temp[indexPath.row];
    return temp.count - 1;
}

- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [myTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.expandable = YES;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CELL";
    
    UITableViewCell *cell = [myTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
 
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self LoadData];
    Categories *cobj=[[catid objectAtIndex:indexPath.row] objectAtIndex:indexPath.subRow-1];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ParseApi" object:nil];
    if([self.mobileind integerValue]==1 && indexPath.row==0)
    {
        UIStoryboard * pStoryboard = [UIStoryboard storyboardWithName:@"Mobiles" bundle:[NSBundle mainBundle]];
        MobilesVC *pVC =[pStoryboard instantiateViewControllerWithIdentifier:@"Mobiles"];
        pVC.title=self.contents[indexPath.section][indexPath.row][indexPath.subRow];
        pVC.branchId=cobj.BranchID;
        pVC.catId=cobj.CatID;
        [self.navigationController pushViewController:pVC animated:YES];
       
    }
    else
    {
        UIStoryboard * pStoryboard = [UIStoryboard storyboardWithName:@"ProductDetail" bundle:[NSBundle mainBundle]];
        ProductViewController *pVC =[pStoryboard instantiateViewControllerWithIdentifier:@"ProductVC"];
        pVC.title=self.contents[indexPath.section][indexPath.row][indexPath.subRow];
        pVC.branchId=cobj.BranchID;
        pVC.catId=cobj.CatID;
        [self.navigationController pushViewController:pVC animated:YES];
        
    }
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.myTable collapseCurrentlyExpandedIndexPaths];
}

-(void)LoadData
{
        for (int i=0;i<obj.CatBranchIDs.count; i++) {
            
            currentCat=[obj.CatBranchIDs objectAtIndex:i];
            
            if([self.catName isEqualToString:currentCat.TMtitle])
            {
                catid=[[NSMutableArray alloc]initWithArray:currentCat.TMCat];
                break;
            }
        }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTable deselectRowAtIndexPath:[self.myTable indexPathForSelectedRow] animated:NO];
     [self.myTable setContentOffset:CGPointZero animated:NO];
 }

@end
