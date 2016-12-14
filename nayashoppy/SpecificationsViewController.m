
//
//  SpecificationsViewController.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SpecificationsViewController.h"
#import "FiltersVC.h"

static NSString *reviewcell=@"Review" , *pricecell=@"Price" , *spListCell=@"SpecificationList";

@interface SpecificationsViewController ()<ReloadSpecificationView,GoToSpecificationList>
{
    NSMutableArray *tabItem;
    PriceViewController *cvc;
    SpecificationListViewController *svc;
    MenuData *obj;
    
}
@property (nonatomic,assign)NSInteger lastSelectedTab;

@end

@implementation SpecificationsViewController
@synthesize title;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    obj=[MenuData Items];
    [self setTab];
    [self nav];  
}


#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if(index==0)
    {
        UIStoryboard *price=[UIStoryboard storyboardWithName:pricecell bundle:nil];
        cvc = [price instantiateViewControllerWithIdentifier:pricecell];
        [self myvc:cvc];
        cvc.ShowListDelegate=self;
        return cvc;
        
    }
     if(index==1)
    {
        UIStoryboard *specification=[UIStoryboard storyboardWithName:spListCell bundle:nil];
        svc = [specification instantiateViewControllerWithIdentifier:spListCell];
        [self myvc:svc];
        return svc;
    }
     else {
         
         UIStoryboard *reviews=[UIStoryboard storyboardWithName:reviewcell bundle:nil];
         ReviewViewController *rvc = [reviews instantiateViewControllerWithIdentifier:reviewcell];
         [self myvc:rvc];
         return rvc;
     }
    
}

- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.text = [tabItem objectAtIndex:index];
    [label autoresizingMask];
    [label sizeToFit];
    label.font=[UIFont systemFontOfSize:12];
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
            return self.view.frame.size.width/3;
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

-(void) myvc:(UIViewController *) vc
{
    vc.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    SWRevealViewController *revealController = [self revealViewController];
    [vc.view addGestureRecognizer:revealController
     .panGestureRecognizer];
    [vc.view addGestureRecognizer:revealController.tapGestureRecognizer];
}

-(void) addTabGesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];

}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

-(void)showList
{
    [self selectTabAtIndex:[obj.tabindex integerValue]];
    
}

-(void) nav
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:self.title andImg:@"Logo" andy:logoY] ;
}

-(void) setTab
{
    tabItem=[[NSMutableArray alloc]initWithObjects:@"PRICES",@"SPECIFICATIONS", @"REVIEWS",nil];
    self.dataSource = self;
    self.delegate = self;
    [self selectTabAtIndex:0];
    self.lastSelectedTab = 0;
}

#pragma mark - ReloadSpecificationView Delegate methods

-(void)ReloadView{
    
    [cvc Parsedetails];
    [cvc arrayObject];
    [cvc.PriceTable reloadData];
    [cvc refreshTableView];

}

@end
