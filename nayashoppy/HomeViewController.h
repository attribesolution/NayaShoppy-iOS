//
//  HomeViewController.h
//  nayashoppy
//
//  Created by Amerald on 27/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponsCollectionViewCell.h"
#import "GlobalVariables.h"
#import "CouponsVC.h"
#import "TableViewCell.h"
#import "TopMenuVc.h"
#import "TopmenuCell.h"
#import "NewArrivalVC.h"
#import "NewArrivalCell.h"
#import "TableCell.h"
#import "RecentCell.h"
#import "RecetVC.h"


@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *LoadingView;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic)  CouponsVC *collectionCont;
@property (strong, nonatomic)  TopMenuVc *topmenu;
@property (strong, nonatomic)  NewArrivalVC *newarrival;
@property (strong, nonatomic)  RecetVC *recent;
@end
