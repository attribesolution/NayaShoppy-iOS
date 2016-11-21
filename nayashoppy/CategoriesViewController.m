//
//  CategoriesViewController.m
//  nayashoppy
//
//  Created by Amerald on 31/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "CategoriesViewController.h"
#import "MenuData.h"
#import "Categories.h"
#import "ProductViewController.h"

@interface CategoriesViewController ()
{
    MenuData *obj;
    NSString *CatName ;
    NSMutableArray *catid;
    Categories *currentCat;
}
@property (nonatomic, strong) NSArray *contents;
@end

@implementation CategoriesViewController
@synthesize myTable;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[MenuData Items];
    self.myTable.frame=CGRectMake(0, 50, 0, 0);
    self.myTable.SKSTableViewDelegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:@"CategorieAtIndex" object:nil];
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


- (void) incomingNotification:(NSNotification *)notification{
    CatName = [notification object];
    
    }

- (NSArray *)contents
{
    
    if (!_contents )
    {
       for (int i=0; i<obj.topmenu.count; i++) {
           
       currentCat=[obj.topmenu objectAtIndex:i];
      
        if([CatName isEqualToString:currentCat.TMtitle])
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
    return [self.contents[section] count];
    
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
        return [self.contents[indexPath.section][indexPath.row] count] - 1;
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
    obj.allproductimg=nil;
    obj.allproducts=nil;
    obj.popularproducts=nil;
    obj.popularproductimg=nil;
    Categories *cobj=[[catid objectAtIndex:indexPath.row] objectAtIndex:indexPath.subRow-1];
    obj.BranchId=cobj.BranchID;
    obj.CatId=cobj.CatID;
   
    UIStoryboard * pStoryboard = [UIStoryboard storyboardWithName:@"ProductDetail" bundle:[NSBundle mainBundle]];
    ProductViewController *pVC =[pStoryboard instantiateViewControllerWithIdentifier:@"ProductVC"];
    pVC.title=self.contents[indexPath.section][indexPath.row][indexPath.subRow];
    [self.navigationController pushViewController:pVC animated:YES];
    
    
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
            
            if([CatName isEqualToString:currentCat.TMtitle])
            {
                catid=[[NSMutableArray alloc]initWithArray:currentCat.TMCat];
                break;
            }
        }
}



@end
