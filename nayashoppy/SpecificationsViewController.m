
//
//  SpecificationsViewController.m
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SpecificationsViewController.h"
#import "FiltersVC.h"
#import "singleton.h"
#import "UIView+UIView_Customize.h"
#import "UIColor+UIColor_Customize.h"

static NSString *reviewcell=@"Review" , *pricecell=@"Price" , *spListCell=@"SpecificationList";

@interface SpecificationsViewController ()<ReloadSpecificationView,GoToSpecificationList>
{
    NSMutableArray *tabItem;
    PriceViewController *cvc;
    SpecificationListViewController *svc;
    ReviewViewController *rvc;
    singleton *obj;
    
}
@property (nonatomic,assign)NSInteger lastSelectedTab;

@end

@implementation SpecificationsViewController
@synthesize title;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self selectTabAtIndex:0];
    obj=[singleton sharedManager];
    [self ParseData];
    [self setTab];
    [self nav];
    [self initializeControllers];
 
}

#pragma mark - ViewPagerControllerDelegate Methods

- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if(index==0)
    {
        cvc.ProCat=self.myobj;
        cvc.ProCatImg=[[NSMutableArray alloc ]initWithArray:self.myobjImg];
        [self myvc:cvc];
        cvc.ShowListDelegate=self;
        return cvc;
        
    }
     if(index==1)
    {
        [self myvc:svc];
        return svc;
    }
     else {
         
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
    [currentlabel setTextColor:[UIColor themeColor]];

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
            return [UIColor themeColor];
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
    [self selectTabAtIndex:1];
}

-(void) nav
{
    CGFloat logoY = floorf(self.navigationController.navigationBar.frame.size.height);
    [self.navigationItem setTitleView:[UIView titleView:self.title andImg:@"Logo" andy:logoY]];
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

-(void)ReloadView:(NSMutableArray *) catarray{
    
    cvc.ProCat= [catarray objectAtIndex:0];
    cvc.ProCatImg= [catarray objectAtIndex:1];
    self.myobj=[catarray objectAtIndex:0];
    [cvc Parsedetails];
    [cvc arrayObject];
    [self ParseData];
    [cvc refreshTableView];
}

-(void) ParseData
{
    ApiParsing * mainVC = [[ApiParsing alloc] init];
   
    [mainVC getDetails:^(NSArray *respone,NSArray *generalFeatures,NSArray *suplier)  {
      
        cvc.supliers=[[NSMutableArray alloc]initWithArray:suplier];
        cvc.GernalFeatures=[[NSMutableArray alloc]initWithArray:generalFeatures];
        [cvc.PriceTable reloadData];
        svc.ProductDetail=[[NSMutableArray alloc]initWithArray:respone];
        [svc.myTable reloadData];
        if( respone.count==0)
        {
            NSArray * nib = [[NSBundle mainBundle]
                             loadNibNamed: @"EmptyView"
                             owner: self
                             options: nil];
            UIView *ev= nib[0];
            ev.frame=CGRectMake(0,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            [svc.view addSubview:ev];
        }
  
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    } slug:_myobj.Pslug
     ];

}

-(void) initializeControllers
{
    UIStoryboard *price=[UIStoryboard storyboardWithName:pricecell bundle:nil];
    cvc = [price instantiateViewControllerWithIdentifier:pricecell];
    UIStoryboard *specification=[UIStoryboard storyboardWithName:spListCell bundle:nil];
    svc = [specification instantiateViewControllerWithIdentifier:spListCell];
    UIStoryboard *reviews=[UIStoryboard storyboardWithName:reviewcell bundle:nil];
    rvc = [reviews instantiateViewControllerWithIdentifier:reviewcell];
}

@end
