//
//  TabledCollectionViewFlowLayout.m
//  AKCollectionController
//
//  Created by kashif Saeed on 02/11/2016.
//  Copyright © 2016 AppsWallet. All rights reserved.
//

#import "TabledCollectionViewFlowLayout.h"


static NSString * const BHPhotoAlbumLayoutPhotoCellKind = @"PhotoCell";

@interface TabledCollectionViewFlowLayout()


@property (nonatomic, strong) NSDictionary *layoutInfo;
@property (nonatomic) UIEdgeInsets itemInsets;

@property (nonatomic) CGFloat interItemSpacingY;

@property (nonatomic) NSInteger originX;
@property (nonatomic) NSInteger originY;
@property (nonatomic) NSInteger cummulativeHeightOfCells;
@end

@implementation TabledCollectionViewFlowLayout


#pragma mark - Lifecycle

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(1.0f, 2.0f, 1.0f, 2.0f);
    self.itemSize = CGSizeMake(125.0f, 180.0f);
    self.interItemSpacingY = 0.0f;
    self.numberOfColumns = 1;
    
}

#pragma mark - Layout

- (void)prepareLayout
{
    self.cummulativeHeightOfCells = 0;
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCellAtIndexPath:indexPath itemNumber:item];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[BHPhotoAlbumLayoutPhotoCellKind] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[BHPhotoAlbumLayoutPhotoCellKind][indexPath];
}
- (CGSize)collectionViewContentSize
{
   
    
    return CGSizeMake(self.collectionView.bounds.size.width, (self.cummulativeHeightOfCells+self.interItemSpacingY +
                      self.itemInsets.bottom+self.itemInsets.top)/_numberOfColumns);
}

#pragma mark - Private

- (CGRect)frameForCellAtIndexPath:(NSIndexPath *)indexPath itemNumber:(NSInteger)item
{

    
    CGFloat width;
    width = floor((self.collectionView.bounds.size.width/self.numberOfColumns)-(self.itemInsets.right + self.itemInsets.left));
    _originX = self.itemInsets.left;
  
    self.originY =  item * (self.itemSize.height+self.itemInsets.top);
    self.cummulativeHeightOfCells = self.cummulativeHeightOfCells+ self.itemSize.height;
    return CGRectMake(_originX, _originY, width, self.itemSize.height);
}

#pragma mark - Properties

- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}
@end
