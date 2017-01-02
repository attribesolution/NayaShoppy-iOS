//
//  DealsOfTheDayViewController.m
//  nayashoppy
//
//  Created by Amerald on 14/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "DealsOfTheDayViewController.h"
#import "ShareUtility.h"
#import "singleton.h"

static NSString *dealsCell = @"DealCell", *keyboardNotification=@"HideKeyboard" , *refreshNotification=@"refreshDealsCV", *specificationSB=@"Specifications" , *placeholder=@"PlaceHolder", *dealsCellNib=@"DealsCell";

@interface DealsOfTheDayViewController ()
{
    singleton *ob;
    Categories *cobj;
    DealsCell *cell;
    NSString *Pimg;
}

@end

@implementation DealsOfTheDayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    ob=[singleton sharedManager];
    /* if(ob.DealsOfTheDay.count==0)
       self.myView.hidden=NO;
     else*/
    self.myView.hidden=YES;
    //  self.DealsOfTheDayCV.backgroundColor=[UIColor whiteColor];
    [self gesture];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDealsCV:)
                                                 name:refreshNotification object:nil];
      }

-(void)refreshDealsCV:(NSNotification *) notification{
    
    [self.DealsOfTheDayCV reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.DealsOfTheDayCV registerNib:[UINib nibWithNibName:dealsCellNib bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)sectio
{
    return ob.newarrival.count;// ob.DealsOfTheDay.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cobj=[ob.newarrival objectAtIndex:indexPath.row];
    ob.PCatId=cobj.PcatId;
    ob.PPrice=cobj.Pprice;
    ob.slug=cobj.Pslug;
    [self ParseData];
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:specificationSB bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:specificationSB];
    dvc.myobj=cobj;
    dvc.myobjImg=[ob.newarrivalImg objectAtIndex:indexPath.row];
    dvc.title=cobj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOL find;
    cobj=[ob.newarrival objectAtIndex:indexPath.row];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];
   /*  Categories *obj=[ob.DealsOfTheDay objectAtIndex:indexPath.row];
        cell.ImageView.image=[ob.DealsOfTheDayImg objectAtIndex:indexPath.row];
        cell.TitleLabel.text=obj.TMtitle;
        cell.PriceLabel.text=[[obj.OfferPrice stringByAppendingString:@"  "]stringByAppendingString:obj.ActualPrice];*/
    Pimg=[[ob.newarrivalImg objectAtIndex:indexPath.row]objectAtIndex:0];
    NSURL *Url = [NSURL URLWithString:Pimg];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:placeholder];
    
    
    __weak DealsCell *weakCell = cell;
    
    [cell.ImageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.ImageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];

    cell.TitleLabel.text=cobj.PName;
    cell.PriceLabel.text=[@"Rs " stringByAppendingString:cobj.Pprice];
    UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.WishButton setImage:image forState:UIControlStateNormal];
    
    for (int d=0; d<myProducts.count; d++) {
        
        NSString * Name=[[[myProducts objectAtIndex:d]objectAtIndex:0]objectAtIndex:0];
        if ([cobj.PName isEqualToString:Name]) {
            find=YES;
            cell.WishButton.tintColor = [UIColor redColor];
            break;
        }
    }
    if(!find)
        cell.WishButton.tintColor = [UIColor darkGrayColor];
    cell.WishButton.tag=indexPath.row;
    cell.ShareButton.tag=indexPath.row;
    [cell.WishButton addTarget:self action:@selector(AddToWishList:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
    

        return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(collectionView.frame.size.width/2-1, collectionView.frame.size.height/3-2);
}
-(void) gesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    tapRecognizer.cancelsTouchesInView = NO;
    [self.DealsOfTheDayCV addGestureRecognizer:tapRecognizer];
    
}
- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyboardNotification object:nil];
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.DealsOfTheDayCV.alwaysBounceVertical = NO;
}

-(void)AddToWishList:(UIButton *) sender
{
    cobj=[ob.newarrival objectAtIndex:sender.tag];
    Pimg=[[ob.newarrivalImg objectAtIndex:sender.tag]objectAtIndex:0];
    [[GlobalVariables class]AddWhishList:cobj.PName :cobj.Pprice :Pimg: self.view];
    cell.WishButton.tintColor = [UIColor redColor];
    [self.DealsOfTheDayCV reloadData];
}

-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:keyboardNotification object:nil];
}

-(void) ParseData
{
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    ob.ProductDetails=nil;
    ob.GernalFeatures=nil;
    [mainVC getDetails:^(NSArray *respone,NSArray *generalFeatures) {
        
        ob.ProductDetails=[respone copy];
        ob.GernalFeatures=[generalFeatures copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:nil];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
}

@end
