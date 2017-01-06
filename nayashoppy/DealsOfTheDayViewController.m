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
#import "EmptyView.h"

static NSString *dealsCell = @"DealCell", *keyboardNotification=@"HideKeyboard" , *refreshNotification=@"refreshDealsCV", *specificationSB=@"Specifications" , *placeholder=@"PlaceHolder", *dealsCellNib=@"DealsCell";

@interface DealsOfTheDayViewController ()
{
    singleton *ob;
    Categories *cobj;
    DealsCell *cell;
    NSString *Pimg;
    NSMutableArray *dealsOfTheDay,*dealsOfTheDayImg;
}

@end

@implementation DealsOfTheDayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    ob=[singleton sharedManager];
    dealsOfTheDay=[[NSMutableArray alloc]init];
    dealsOfTheDayImg=[[NSMutableArray alloc]init];
    [self ParseData];
    [self gesture];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.DealsOfTheDayCV registerNib:[UINib nibWithNibName:dealsCellNib bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:dealsCell];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dealsOfTheDay.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    cobj=[dealsOfTheDay objectAtIndex:indexPath.row];
    ob.PCatId=cobj.PcatId;
    ob.PPrice=cobj.Pprice;
    [self ParseData];
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:specificationSB bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:specificationSB];
    dvc.myobj=cobj;
    dvc.myobjImg=[dealsOfTheDayImg objectAtIndex:indexPath.row];
    dvc.title=cobj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOL find;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:dealsCell forIndexPath:indexPath];
    
   Categories *obj=[dealsOfTheDay objectAtIndex:indexPath.row];
        cell.TitleLabel.text=obj.TMtitle;
        cell.PriceLabel.text=[@"Rs " stringByAppendingString:obj.OfferPrice];
    
    Pimg=[[dealsOfTheDayImg objectAtIndex:indexPath.row]objectAtIndex:0];
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

    UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell.WishButton setImage:image forState:UIControlStateNormal];
    
    find=[[GlobalVariables class]IsFound:obj.TMtitle];
    if(!find)
        cell.WishButton.tintColor = [UIColor darkGrayColor];
    else
        cell.WishButton.tintColor = [UIColor redColor];

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.DealsOfTheDayCV.alwaysBounceVertical = NO;
}

-(void)AddToWishList:(UIButton *) sender
{
    cobj=[dealsOfTheDay objectAtIndex:sender.tag];
    Pimg=[[dealsOfTheDayImg objectAtIndex:sender.tag]objectAtIndex:0];
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
    [mainVC DealsOfTheDay: ^(NSMutableArray *array,NSMutableArray *img) {
        
        dealsOfTheDay=[array copy];
        dealsOfTheDayImg=[img copy];
        if(dealsOfTheDay.count==0)
       {
           
            NSArray * nib = [[NSBundle mainBundle]
                             loadNibNamed: @"EmptyView"
                             owner: self
                             options: nil];
            UIView *ev= nib[0];
            ev.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:ev];
           
        }
        else
        {
          [self.DealsOfTheDayCV reloadData];
        }
 
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
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

@end
