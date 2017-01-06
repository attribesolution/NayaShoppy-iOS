//
//  SimilarProductVC.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "SimilarProductVC.h"
#import "ShareUtility.h"
#import "singleton.h"
#import "GlobalVariables.h"

static NSString *similarPCell=@"SimilarPCVCell", *similarProduct=@"SimilarProducts" ,*placeHolderImg=@"PlaceHolder",*wishIcon=@"WishIcon" ,*notification=@"refreshTable";

@interface SimilarProductVC ()
{
    singleton *obj;
    Categories *cobj;
    NSString *imgUrl;
    SimilarPCVCell *cell;
    NSMutableArray *Similarproductimg,*Similarproducts;

}
@end

@implementation SimilarProductVC
@synthesize SimilarPcollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    Similarproductimg=[[NSMutableArray alloc]init];
    Similarproducts=[[NSMutableArray alloc]init];
    [super viewWillAppear:animated];
    [self.SimilarPcollView registerNib:[UINib nibWithNibName:similarPCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:similarPCell];
    self.SimilarPcollView.backgroundColor=[UIColor clearColor];
    [self getSimilarPro];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return Similarproducts.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cobj=[Similarproducts objectAtIndex:indexPath.row];
    NSMutableArray *catarr=[[NSMutableArray alloc]init];
    [catarr addObject:cobj];
    [catarr addObject:[Similarproductimg objectAtIndex:indexPath.row]];
    if([self.XYZDelegate respondsToSelector:@selector(ReloadView:)])
        [self.XYZDelegate ReloadView:catarr];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL find=NO;
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:similarPCell forIndexPath:indexPath];
    cobj=[Similarproducts objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];

    NSURL *Url = [NSURL URLWithString:[[Similarproductimg objectAtIndex:indexPath.row]objectAtIndex:0]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:placeHolderImg];
    
    __weak SimilarPCVCell *weakCell = cell;
    
    [cell.Image setImageWithURLRequest:request
                      placeholderImage:placeholderImage
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   weakCell.Image.image = image;
                                   [weakCell setNeedsLayout];
                                   
                               } failure:nil];
    
    
    UIImage *image = [[UIImage imageNamed:wishIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.WishIcon setImage:image forState:UIControlStateNormal];

    find=[[GlobalVariables class]IsFound:cobj.PName];
    if(!find)
        cell.WishIcon.tintColor = [UIColor darkGrayColor];
    else
        cell.WishIcon.tintColor = [UIColor redColor];
    
    cell.WishIcon.tag=indexPath.row;
    cell.ShareIcon.tag=indexPath.row;
    [cell.WishIcon addTarget:self action:@selector(AddToWishList:)forControlEvents:UIControlEventTouchUpInside];
    [cell.ShareIcon addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];

    cell.Title.text=cobj.PName;
    cell.Company.text=cobj.POfferPrice;
    return cell;
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2-1, 180);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.SimilarPcollView.alwaysBounceHorizontal=NO;
}

-(void)AddToWishList:(UIButton *) sender
{   cobj=[Similarproducts objectAtIndex:sender.tag];
    imgUrl=[[Similarproductimg objectAtIndex:sender.tag]objectAtIndex:0];
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.POfferPrice :imgUrl: self.view];
    cell.WishIcon.tintColor = [UIColor redColor];
     [self.SimilarPcollView reloadData];
}

-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}
-(void) getSimilarPro
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    SpecificationsViewController *svc=(SpecificationsViewController *) [appDelegate.navController topViewController];
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    
    [mainVC getSimilarProducts:^(NSArray *respone,NSArray *img) {
        
        Similarproductimg=[img copy];
        Similarproducts=[respone copy];
        [self.SimilarPcollView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"StopInd" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }
     catId:svc.myobj.PcatId Price:svc.myobj.Pprice
     ];

}

@end
