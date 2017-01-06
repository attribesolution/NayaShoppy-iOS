//
//  GridListViewController.h
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiParsing.h"
#import "SpecificationsViewController.h"
#import "FiltersVC.h"

@interface GridListViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITabBarDelegate>
- (IBAction)FilterButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *Loader;
-(void) shuffle;
@property (strong, nonatomic) IBOutlet UIView *FilterView;
@property (strong, nonatomic) IBOutlet UICollectionView *GLCollectionView;
@property(copy,nonatomic) NSNumber *tabindex;
//@property(copy,nonatomic) NSString *branchId,*catId;
@property(strong,nonatomic) NSNumber *page;
@end
