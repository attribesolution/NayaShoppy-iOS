//
//  FiltersVC.m
//  nayashoppy
//
//  Created by Amerald on 28/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "FiltersVC.h"
#import "checkCell.h"
#import "MenuData.h"
#import "GlobalVariables.h"
#import "Categories.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>
@interface FiltersVC ()
{
    NSArray *filter,*filtervalues;
    DGActivityIndicatorView *activityIndicatorView;
    Categories *cobj;
    MenuData *obj;
    NSString *key;
}
@end

@implementation FiltersVC
@synthesize Laoder;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[MenuData Items];
    [self navBar];
    UINib *cell = [UINib nibWithNibName:@"checkCell" bundle:nil];
    [self.FilterDTable registerNib:cell forCellReuseIdentifier:@"check"];
    self.FilterDTable.hidden=YES;
    filter=[[NSArray alloc]init];
    filtervalues=[[NSArray alloc]init];
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Laoder.bounds;
    [self.Laoder addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    ApiParsing * mainVC = [[ApiParsing alloc] init];
     
     [mainVC getFilters:^(NSArray *items) {
     
     filter=[items copy];
     [self.FilterNTable reloadData];
     [activityIndicatorView stopAnimating];

     } failure:^(NSError *error, NSString *message) {
     NSLog(@"%@",error);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==1)
    return filter.count;
    else
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1)
        return 1;
    else
        return filtervalues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cobj=[filter objectAtIndex:indexPath.section];
    
    if(tableView.tag==1)
    {
    
    static NSString *simpleTableIdentifier = @"CELL";
    
    UITableViewCell *cell = [_FilterNTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text=cobj.filterName;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
    }
    
    else
    {
        static NSString *simpleTableIdentifier = @"check";
        
        checkCell *cell = (checkCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"checkCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.ValueLabel.text=[filtervalues objectAtIndex:indexPath.row];
        cell.CheckButton.tag=indexPath.row;
        [cell.CheckButton setImage:nil forState:UIControlStateNormal];
        for (int i=0; i<obj.MarkedFilters.count; i++) {
          if ([obj.MarkedFilters objectForKey:key]!=nil)
            if([[obj.MarkedFilters valueForKey:key] isEqualToString:cell.ValueLabel.text])
                [cell.CheckButton setImage:[UIImage imageNamed:@"icon_chack.png"] forState:UIControlStateNormal];
        }
        
        [cell.CheckButton addTarget:self action:@selector(checkMark:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.FilterDTable.hidden=NO;
    filtervalues=nil;
    cobj=[filter objectAtIndex:indexPath.section];
    key=cobj.filterName;
    filtervalues=[cobj.FilterValues copy];
    [self.FilterDTable reloadData];
    
}
-(void) checkMark:(UIButton *) sender
{
    
      [obj.MarkedFilters setObject:[filtervalues objectAtIndex:sender.tag] forKey:key];
      [sender setImage:[UIImage imageNamed:@"icon_chack.png"] forState:UIControlStateNormal];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.FilterDTable.alwaysBounceVertical=NO;
    self.FilterNTable.alwaysBounceVertical=NO;
}
- (IBAction)BackButton:(id)sender {
   
}
- (IBAction)ResetButton:(id)sender {
    
    [obj.MarkedFilters removeAllObjects] ;
    [self.FilterDTable reloadData];
}
- (IBAction)ApplyFilterButton:(id)sender {
}
-(void) navBar
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"Filters            " andImg:@"Logo" andy:logoY] ;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

}
@end
