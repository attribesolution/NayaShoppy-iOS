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

@interface ProductViewController (){
 NSMutableArray *tabItem;
}
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabItem=[[NSMutableArray alloc]initWithObjects:@"HOME",@"DEALS OF THE DAY", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //[self myvc:cvc];
        return cvc;
        
    }
    
    else
    {
        UIStoryboard *deals=[UIStoryboard storyboardWithName:@"DealsStoryboard" bundle:nil];
        DealsOfTheDayViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"deals"];
        //[self myvc:dvc];
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

/*-(void) navBar
{
 
   
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
}*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
