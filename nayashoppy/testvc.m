//
//  testvc.m
//  nayashoppy
//
//  Created by Amerald on 21/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "testvc.h"

@interface testvc ()
{
    singleton *obj;
    NSString *CatName ;
    NSMutableArray *catid;
    Categories *currentCat;
    CGFloat tableY;
}

@property (nonatomic, strong) NSArray *contents;
@end

@implementation testvc
@synthesize myTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
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
    NSArray * temp = self.contents[section];
    return  temp.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CELL";
    
    UITableViewCell *cell = [myTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
    cell.backgroundColor=[UIColor purpleColor];
    return cell;
}


- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self LoadData];
    obj.allproductimg=nil;
    obj.allproducts=nil;
    obj.popularproducts=nil;
    obj.popularproductimg=nil;
    Categories *cobj=[[catid objectAtIndex:indexPath.row] objectAtIndex:0];
    obj.BranchId=cobj.BranchID;
    obj.CatId=cobj.CatID;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ParseApi" object:nil];
    if([obj.Mobileindex integerValue]==1 && indexPath.row==0)
    {
        UIStoryboard * pStoryboard = [UIStoryboard storyboardWithName:@"Mobiles" bundle:[NSBundle mainBundle]];
        MobilesVC *pVC =[pStoryboard instantiateViewControllerWithIdentifier:@"Mobiles"];
        pVC.title=self.contents[indexPath.section][indexPath.row][0];
        [self.navigationController pushViewController:pVC animated:YES];
        
    }
    else
    {
        UIStoryboard * pStoryboard = [UIStoryboard storyboardWithName:@"ProductDetail" bundle:[NSBundle mainBundle]];
        ProductViewController *pVC =[pStoryboard instantiateViewControllerWithIdentifier:@"ProductVC"];
        pVC.title=self.contents[indexPath.section][indexPath.row][0];
        [self.navigationController pushViewController:pVC animated:YES];
        
    }
}

#pragma mark - Actions

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTable deselectRowAtIndexPath:[self.myTable indexPathForSelectedRow] animated:NO];
    // [self.myTable setContentOffset:CGPointZero animated:NO];
    // self.myTable.frame=CGRectMake(0,tableY, self.myTable.frame.size.width, self.myTable.frame.size.height);
    
}

@end
