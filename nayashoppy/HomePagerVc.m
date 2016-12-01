//
//  HomePagerVc.m
//  nayashoppy
//
//  Created by Amerald on 01/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "HomePagerVc.h"

@interface HomePagerVc ()
{
    NSMutableArray *tabItem;
    NSString *baseurl;
    
}
@property (nonatomic,assign)NSInteger lastSelectedTab;
@end

@implementation HomePagerVc

@synthesize Lmenu,Rmenu,vp;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navBar];
    tabItem=[[NSMutableArray alloc]initWithObjects:@"HOME",@"DEALS OF THE DAY", nil];
    self.lastSelectedTab = 0;
    self.dataSource = self;
    self.delegate = self;
    [self gesture];
    [self selectTabAtIndex:0];
    // [self EmptyUserDefaults];
    
}
-(void)viewDidAppear:(BOOL)animated
{
   //[self.view bringSubviewToFront:self.searchbar];
    
}
#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 2;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if(index==0)
    {
        UIStoryboard *categoriesSB=[UIStoryboard storyboardWithName:@"HomeView" bundle:nil];
        HomeViewController *cvc = [categoriesSB instantiateViewControllerWithIdentifier:@"Home"];
        [self myvc:cvc];
        return cvc;
    }
    
    else
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"DealsStoryboard" bundle:nil];
        DealsOfTheDayViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"deals"];
        [self myvc:dvc];
        return dvc;
    }
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.text = [tabItem objectAtIndex:index];
    [label autoresizingMask];
    [label sizeToFit];
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.tag=100+index;
    return label;
}
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    
    UILabel *previouslabel = (UILabel*)[viewPager.view viewWithTag:100+self.lastSelectedTab];
    previouslabel.textColor = [UIColor blackColor];
    
    UILabel *currentlabel = (UILabel*)[viewPager.view viewWithTag:100+index];
    currentlabel.textColor = [GlobalVariables themeColor];
    
    self.lastSelectedTab = index;
}

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    
    switch (option) {
        case ViewPagerOptionTabWidth:
            return self.view.frame.size.width/2;
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 0.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabOffset:
            return 60;
        default:
            return value;
    }
}
- (CGFloat)valueForOption:(ViewPagerOption)option {
    
    switch (option) {
        case ViewPagerOptionTabOffset:
            return 60;
        default:
            return NAN;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [GlobalVariables themeColor];
        default:
            return color;
    }
}

-(void) myvc:(UIViewController *) vc
{
    vc.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    SWRevealViewController *revealController = [self revealViewController];
    [vc.view addGestureRecognizer:revealController
     .panGestureRecognizer];
    [vc.view addGestureRecognizer:revealController.tapGestureRecognizer];
}
- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
-(void) gesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    
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
                                                               style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    
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


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

-(void) EmptyUserDefaults
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Product"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ProductImg"];
}

@end
