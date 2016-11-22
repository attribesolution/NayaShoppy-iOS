//
//  PriceViewController.h
//  nayashoppy
//
//  Created by Amerald on 10/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
#import "DetailCell.h"
#import "GlobalVariables.h"
#import "MenuData.h"
#import "StoreCell.h"
#import "ReviewCell.h"
#import "SimilarProductVC.h"
#import "SimilarProductsCell.h"
#import "SpecificationCell.h"
#import "CollectionImages.h"
#import "SpecificationButtonCell.h"

@protocol GoToSpecificationList <NSObject>

@optional
-(void)doSomething;
@required
-(void)showList;
@end


@interface PriceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *PriceTable;
@property (strong, nonatomic) CollectionImages *imgcv;
@property (strong, nonatomic) IBOutlet UIView *ToastView;
@property (strong, nonatomic)  id <GoToSpecificationList> ShowListDelegate;

-(void) Parsedetails;
-(void) arrayObject;
-(void) refreshTableView;
@end
