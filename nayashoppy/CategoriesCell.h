//
//  CategoriesCell.h
//  nayashoppy
//
//  Created by Amerald on 18/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriesCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *customLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;


@end
