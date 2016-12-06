

//
//  SpecificationListViewController.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SpecificationListViewController.h"

@interface SpecificationListViewController ()
{
    NSNumber *index;
    MenuData *obj;
}
@property (nonatomic, strong) NSArray *contents;
@property(nonatomic,strong) PriceViewController *pvc;


@end

@implementation SpecificationListViewController

@synthesize myTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    self.myTable.frame=CGRectMake(0, 50, 0, 0);
    self.myTable.SKSTableViewDelegate = self;

    self.navigationController.navigationItem.backBarButtonItem.title = @" ";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshTable" object:nil];
}
-(void)refreshView:(NSNotification *) notification {
    
    [self.myTable reloadData];
     _contents = @[obj.ProductDetails];
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
    
    if (!_contents && obj.ProductDetails!=nil)
    {
          _contents = @[obj.ProductDetails];
        
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
     
    static NSString *simpleTableIdentifier = @"SpecificationCell";
    
    SpecificationCell *cell = (SpecificationCell *)[myTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SpecificationCell" owner:self options:  nil];
        cell = [nib objectAtIndex:0];
    }
    Categories *cobj=[[[_contents objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectAtIndex:indexPath.subRow];
    cell.name.text = cobj.featurename;
    cell.value.text=cobj.featurevalue;
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}


- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Actions

- (void)collapseSubrows
{
    [self.myTable collapseCurrentlyExpandedIndexPaths];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.myTable deselectRowAtIndexPath:[self.myTable indexPathForSelectedRow] animated:NO];
    [self.myTable setContentOffset:CGPointZero animated:NO];
    
}

@end
