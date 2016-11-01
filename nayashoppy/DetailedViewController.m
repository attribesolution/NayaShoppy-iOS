
//
//  DetailedViewController.m
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()
{
     NSMutableArray *tabItem,*categories;
    MenuData *obj;
}
@end

@implementation DetailedViewController


- (void)viewDidLoad {
    
    obj=[MenuData Items];
    categories=[[NSMutableArray alloc]init];
    if(obj.topmenu.count!=0)
    {
    for (int i=0; i<obj.topmenu.count; i++) {
         Categories *currentCat=[obj.topmenu objectAtIndex:i];
        [categories addObject:currentCat.TMtitle];
    }
    }
    tabItem=[[NSMutableArray alloc] initWithArray:categories];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapRecognizer];
    self.dataSource = self;
    self.delegate = self;
    
   [self navBar];
}

#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return categories.count;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
   
    UIStoryboard *deals=[UIStoryboard storyboardWithName:@"Categories" bundle:nil];
      DealsOfTheDayViewController *dvc = [deals instantiateViewControllerWithIdentifier:@"Categories"];
      dvc.view.backgroundColor=[UIColor whiteColor];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"CategorieAtIndex" object:categories[index]];
       return dvc;
}
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {

    
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
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
        default:
            return color;
    }
}
#pragma mark - self.view Methods


-(void) navBar
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    self.navigationItem.titleView =[[GlobalVariables class] titleView:@"Shop By Categories            " andImg:@"Logo" andy:logoY] ;
    
    
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}


@end
