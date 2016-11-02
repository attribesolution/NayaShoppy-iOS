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

@interface CategoriesViewController ()
{
    MenuData *obj;
    NSString *CatName ;
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
        Categories *currentCat=[obj.topmenu objectAtIndex:i];
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
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKSTableViewCell";
    
    SKSTableViewCell *cell = [myTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
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
 /*   if(indexPath.section==0 && indexPath.row==2)
    {
        Categories *currentCat=[CategoriesArray objectAtIndex:indexPath.subRow-1];
        cell.textLabel.text=currentCat.CName ;
    }
    
    else*/
        cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

/*
- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0 && indexPath.row==2)
    {
        Categories *c1= [CategoriesArray objectAtIndex:indexPath.subRow-1];
        CID=c1.CId;
        CTitle=c1.CName;
        [self performSegueWithIdentifier:@"Menu" sender:self];
        
    }
    if(indexPath.section==0 && indexPath.row==1)
        [self performSelector:@selector(goToNextView) withObject:nil ];
    
    if(indexPath.section==0 && indexPath.row==0 && indexPath.subRow==1)
        [self performSegueWithIdentifier:@"MYOrder" sender:self];
    if(indexPath.section==0 && indexPath.row==0 && indexPath.subRow==2)
        [self performSegueWithIdentifier:@"MyReservation" sender:self];
    
}
*/
#pragma mark - Actions

- (void)collapseSubrows
{
    [self.myTable collapseCurrentlyExpandedIndexPaths];
}


@end
