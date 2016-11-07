//
//  ViewController.m
//  nayashoppy
//
//  Created by Amerald on 03/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Lmenu,Rmenu,PagerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navBar];
  
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"HomePager" bundle:nil];
    self.pager = [coupons instantiateViewControllerWithIdentifier:@"Pager"];
    //self.pager.view.backgroundColor=[UIColor redColor];
    [self addChildViewController:self.pager];
    [self.pager didMoveToParentViewController:self];
   
    
    [self.PagerView addSubview:self.pager.view];
  /*
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"Coupons" bundle:nil];
    self.collectionCont = [coupons instantiateViewControllerWithIdentifier:@"Cash"];
    [self addChildViewController:self.collectionCont];
    [self.PagerView addSubview:self.collectionCont.view]; */

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.pager.view.frame=self.PagerView.bounds;
     //self.pager.view.frame=CGRectMake(0,0, self.PagerView.frame.size.width, self.PagerView.frame.size.height);
}
#pragma mark - self.view Methods


-(void) navBar
{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *menu1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.searchbar.delegate=self;
    NSArray *leftButtonItems = @[menu1];
    
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"NAYA SHOPPY" andImg:@"Logo" andy:logoY] ;
    
    UIBarButtonItem *rightRevealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"User"]
                                                                              style:UIBarButtonItemStylePlain target:revealController action:@selector(rightRevealToggle:)];
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Share"]
                                                              style:UIBarButtonItemStylePlain  target:self action:nil];
    share.tintColor=[UIColor whiteColor];
    
    NSArray *actionButtonItems = @[rightRevealButtonItem, share];
    
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    self.navigationItem.leftBarButtonItems = leftButtonItems;
    
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.navController=self.navigationController;
    
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

@end
