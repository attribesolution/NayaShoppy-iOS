//
//  PagerViewController.m
//  nayashoppy
//
//  Created by Amerald on 04/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "PagerViewController.h"

@interface PagerViewController ()
{
    NSMutableArray *tabItem;
    NSString *baseurl;
    
}
@property (nonatomic,assign)NSInteger lastSelectedTab;
@end

@implementation PagerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    tabItem=[[NSMutableArray alloc]initWithObjects:@"HOME",@"DEALS OF THE DAY", nil];
    self.lastSelectedTab = 0;
    self.dataSource = self;
    self.delegate = self;
    [self gesture];
    [self selectTabAtIndex:0];
  
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
@end
