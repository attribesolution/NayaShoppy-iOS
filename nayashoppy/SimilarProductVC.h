//
//  SimilarProductVC.h
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimilarPCVCell.h"
#import "ApiParsing.h"
#import "Categories.h"

@interface SimilarProductVC : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *SimilarPcollView;

@end
