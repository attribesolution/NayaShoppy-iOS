//
//  ProductViewController.m
//  nayashoppy
//
//  Created by kashif Saeed on 03/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ProductViewController.h"
#import "UINavigationItem+Customize.h"
#import "HomeViewController.h"
#import "DetailedViewController.h"
#import "GlobalVariables.h"
#import "singleton.h"

@interface ProductViewController (){
    NSMutableArray *tabItem;
    NSInteger numberOfTabs,tab ;
    singleton *obj;
}

@property (nonatomic,assign)NSInteger lastSelectedTab;
@end

@implementation ProductViewController
@synthesize PPvc,APvc,title,TaostView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[singleton sharedManager];
    tabItem=[[NSMutableArray alloc]initWithObjects:@"ALL PRODUCTS",@"POPULAR PRODUCTS", nil];
    numberOfTabs = 2;
    self.dataSource = self;
    self.delegate = self;
    [self selectTabAtIndex:0];
    self.lastSelectedTab = 0;
    [self navBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return numberOfTabs;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    obj.page=[NSNumber numberWithInt:1];
    UIStoryboard *categoriesSB=[UIStoryboard storyboardWithName:@"GridList" bundle:nil];
    if(index==0)
    {
        
        self.APvc = [categoriesSB instantiateViewControllerWithIdentifier:@"GridList"];
        APvc.tabindex=[NSNumber numberWithInteger: index];
        return self.APvc;
    }
    else
    {
        self.PPvc = [categoriesSB instantiateViewControllerWithIdentifier:@"GridList"];
        PPvc.tabindex=[NSNumber numberWithInteger: index];
        return self.PPvc;
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
    label.tag = 100+index;
    return label;
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
        default:
            return value;
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

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{

    if(index==0)
        tab=0;
    else
        tab=1;
        UILabel *previouslabel = (UILabel*)[viewPager.view viewWithTag:100+self.lastSelectedTab];
        previouslabel.textColor = [UIColor blackColor];
    
        UILabel *currentlabel = (UILabel*)[viewPager.view viewWithTag:100+index];
        currentlabel.textColor = [GlobalVariables themeColor];
    
        self.lastSelectedTab = index;
}

-(void) navBar
{

    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:self.title andImg:@"Logo" andy:logoY] ;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Grid"]
                                                                               style:UIBarButtonItemStylePlain target:self action:@selector(Shuffle)];

    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
}

-(void) Shuffle
{
   if(tab==0)
    [self.APvc shuffle];
   else
    [self.PPvc shuffle];
}

@end
