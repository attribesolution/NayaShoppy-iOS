

//
//  SpecificationListViewController.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SpecificationListViewController.h"
#import "singleton.h"
#import "EmptyView.h"

static NSString *specificationCell=@"SpecificationCell", *tableCell= @"SKSTableViewCell", *notification=@"refreshTable";

@interface SpecificationListViewController ()
{
    NSNumber *index;
    singleton *obj;
   
}

@property (nonatomic, strong) NSArray *contents;
@property(nonatomic,strong) PriceViewController *pvc;

@end

@implementation SpecificationListViewController
@synthesize myTable,ProductDetail;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    obj=[singleton sharedManager];
    self.myTable.frame=CGRectMake(0, 50, 0, 0);
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
    
    if (!_contents && ProductDetail!=nil)
    {
          _contents = @[ProductDetail];
        
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
    SKSTableViewCell *cell = [myTable dequeueReusableCellWithIdentifier:tableCell];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCell];
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.expandable = YES;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SpecificationCell *cell = (SpecificationCell *)[myTable dequeueReusableCellWithIdentifier:specificationCell];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:specificationCell owner:self options:  nil];
        cell = [nib objectAtIndex:0];
    }
    
    Categories *cobj=[[[_contents objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]objectAtIndex:indexPath.subRow];
    
    CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[cell.name font]}];
    CGFloat strikeWidth = textSize.width;
    CGFloat Dlines=(strikeWidth/cell.name.frame.size.width+1)*25+25;
    
    cell.name.frame=CGRectMake(cell.name.frame.origin.x,cell.name.frame.origin.y,cell.name.frame.size.width, Dlines);

    cell.name.text = cobj.featurename;
    
    CGSize textSize1 = [cobj.featurevalue sizeWithAttributes:@{NSFontAttributeName:[cell.value font]}];
    CGFloat strikeWidth1 = textSize1.width;
    CGFloat Dlines1=(strikeWidth1/cell.value.frame.size.width+1)*25+25;
    
    cell.value.frame=CGRectMake(cell.value.frame.origin.x,cell.value.frame.origin.y,cell.value.frame.size.width, Dlines1);

    cell.value.text=cobj.featurevalue;
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
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
    [super viewWillAppear:animated];
       
}

@end
