
//
//  DetailedViewController.m
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "DetailedViewController.h"
#import "singleton.h"
#import "UIView+UIView_Customize.h"
#import "UIColor+UIColor_Customize.h"

@interface DetailedViewController ()
{
     NSMutableArray *tabItem,*categories;
     singleton *obj;
     AppDelegate *appDelegate;
     CategoriesViewController *dvc;
    int ind;
}

@property (nonatomic,assign)NSInteger lastSelectedTab;
@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ind=0;
    obj=[singleton sharedManager];
    categories=[[NSMutableArray alloc]init];
    [self selectTabAtIndex:0];
    self.lastSelectedTab = 0;
    self.view.backgroundColor=[UIColor clearColor];
    if(obj.topmenu.count!=0)
    {
    for (int i=0; i<obj.topmenu.count; i++) {
         Categories *currentCat=[obj.topmenu objectAtIndex:i];
        [categories addObject:currentCat.TMtitle];
    }
    }
    
    tabItem=[[NSMutableArray alloc] initWithArray:categories];
    [self setdeleget];
    [self addgesture];
    [self navBar];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if(self.selectTab!=nil)
    [self selectTabAtIndex:[self.selectTab integerValue]];
}
-(void) viewWillDisappear:(BOOL)animated
{
    self.selectTab=nil;
}

#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return categories.count;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    UIStoryboard *deals=[UIStoryboard storyboardWithName:@"Categories" bundle:nil];
    dvc = [deals instantiateViewControllerWithIdentifier:@"Categories"];
    if(index==0)
        dvc.mobileind=[NSNumber numberWithInt:1];
    dvc.view.backgroundColor=[UIColor whiteColor];
    dvc.catName=categories[index];
    return dvc;
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.text = [tabItem objectAtIndex:index];
    [label autoresizingMask];
    [label sizeToFit];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.tag=100+index;
    return label;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index{
    
    UILabel *previouslabel = (UILabel*)[viewPager.view viewWithTag:100+self.lastSelectedTab];
    previouslabel.textColor = [UIColor blackColor];
    previouslabel.font=[UIFont systemFontOfSize:13];
    UILabel *currentlabel = (UILabel*)[viewPager.view viewWithTag:100+index];
    currentlabel.font=[UIFont systemFontOfSize:14];
    [currentlabel setTextColor:[UIColor themeColor]];
 
    self.lastSelectedTab = index;
}

- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionTabWidth:
            return self.view.frame.size.width/2-1;
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        default:
            return value;
    }
}

- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        default:
            return color;
    }
}

#pragma mark - self.view Methods

-(void) navBar
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    [self.navigationItem.titleView titleView:@"Shop By Categories            " andImg:@"Logo" andy:logoY] ;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)addgesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) setdeleget
{
    self.dataSource = self;
    self.delegate = self;
}

@end
