//
//  ViewController.m
//  nayashoppy
//
//  Created by Amerald on 03/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ShareUtility.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Lmenu,Rmenu,PagerView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self navBar];
    [self addPagerView];
   // [self EmptyUserDefaults];
    [self UserDefaults];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"HideKeyboard" object:nil];
}

-(void)refreshView:(NSNotification *) notification {
    
    [self.view endEditing:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     self.pager.view.frame=self.PagerView.bounds;
    [self.view bringSubviewToFront:self.searchbar];
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
    UILabel *title=[[UILabel alloc]init];
    title.font=[UIFont fontWithName:@"fontello" size:30];
    title.text=[NSString stringWithUTF8String:"\uf1e0"];
    title.textColor = [UIColor blackColor];

    UIBarButtonItem *share =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share 17*17"]
                                                               style:UIBarButtonItemStylePlain target:self action:@selector(share)];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void) EmptyUserDefaults
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Product"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ProductImg"];
}

-(void) addPagerView
{
    UIStoryboard *coupons=[UIStoryboard storyboardWithName:@"HomePager" bundle:nil];
    self.pager = [coupons instantiateViewControllerWithIdentifier:@"Pager"];
    [self addChildViewController:self.pager];
    [self.pager didMoveToParentViewController:self];
    [self.PagerView addSubview:self.pager.view];
}

-(void) UserDefaults
{
    defaults = [NSUserDefaults standardUserDefaults];
    myProducts = [defaults objectForKey:@"Product"];
}
-(void) share
{
    NSString *appUrl=@"Let me recommend you this application \n https://play.google.com/store/apps/details?id=com.attribe.nayashoppy.app ";
    [[ShareUtility class]shareObject:@[appUrl]];
}
@end
