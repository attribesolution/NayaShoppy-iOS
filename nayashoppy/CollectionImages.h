//
//  CollectionImages.h
//  nayashoppy
//
//  Created by Amerald on 14/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCVcell.h"


@interface CollectionImages : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *ImgCView;

@end
