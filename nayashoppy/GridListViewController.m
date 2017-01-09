//
//  GridListViewController.m
//  nayashoppy
//
//  Created by Amerald on 08/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "GridListViewController.h"
#import "TabledCollectionViewFlowLayout.h"
#import "CollectionCell.h"
#import "TabelledCollectionCell.h"
#import "GridCollectionViewFlowLayout.h"
#import "DGActivityIndicatorView.h"
#import "ShareUtility.h"
#import "singleton.h"
#import "ProductViewController.h"

static NSString *AKCollectionCell = @"CollectionCell";
static NSString *AKTabelledCollectionCell = @"TabelledCollectionCell";

@interface GridListViewController ()
{
    singleton *obj;
    DGActivityIndicatorView *activityIndicatorView;
    Categories *cobj;
    CollectionCell *cell;
    TabelledCollectionCell *Tcell;
    NSMutableArray *allproducts,*allproductimg,*popularproductimg,*popularproducts;
    NSString *imgUrl;
    UIImage *wishimg;
    CGFloat Dlines;
    int i;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic)TabledCollectionViewFlowLayout *tLayout;
@property (strong, nonatomic)GridCollectionViewFlowLayout *glayout;
@end

Boolean showInGridView = false;
@implementation GridListViewController
@synthesize Loader,tabindex,FilterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _page=[NSNumber numberWithInt:1];
    allproducts=[[NSMutableArray alloc]init];
    allproductimg=[[NSMutableArray alloc]init];
    popularproductimg=[[NSMutableArray alloc]init];
    popularproducts=[[NSMutableArray alloc]init];
    obj=[singleton sharedManager];
    self.FilterView.hidden=YES;
    [self ApiParsing];
    [self registerCell];
    [self setLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incomingNotification:) name:@"ParseApi" object:nil];
}

- (void) incomingNotification:(NSNotification *)notification{
    [self ApiParsing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) shuffle
{
    showInGridView = !showInGridView;
    
    if(showInGridView){
        
        [self.collectionView registerNib:[UINib nibWithNibName:AKTabelledCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKTabelledCollectionCell];
        [self.collectionView setCollectionViewLayout:self.glayout animated:YES completion:^(BOOL finished) {
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
             [self.collectionView reloadData];
        }];
        
        
    }else{
        
        [self.collectionView registerNib:[UINib nibWithNibName:AKCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKCollectionCell];
        
        [self.collectionView setCollectionViewLayout:self.tLayout animated:YES completion:^(BOOL finished) {
            
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:(UICollectionViewScrollPositionTop) animated:NO];
            [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
              [self.collectionView reloadData];
        }];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [[self loadArray] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BOOL find;
    find=NO;
    cobj=[[self loadArray] objectAtIndex:indexPath.row];
    
    if(showInGridView){
        Tcell =  [collectionView dequeueReusableCellWithReuseIdentifier:AKTabelledCollectionCell forIndexPath:indexPath];
        
        CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[Tcell.GridName font]}];
        CGFloat strikeWidth = textSize.width;
        Dlines=(strikeWidth/Tcell.GridName.frame.size.width+1)*25+25;
        
        Tcell.GridName.frame=CGRectMake(Tcell.GridName.frame.origin.x,Tcell.GridName.frame.origin.y, Tcell.GridName.frame.size.width, Dlines);
        
        Tcell.GridName.text=cobj.PName;
        Tcell.Company.text=[@"Rs " stringByAppendingString:cobj.Pprice];

        NSURL *Url = [NSURL URLWithString:[self ImgUrl:indexPath.row]];
        NSURLRequest *request = [NSURLRequest requestWithURL:Url];
        UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
        
        __weak TabelledCollectionCell *weakCell = Tcell;
        
        [Tcell.GridImage setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.GridImage.image = image;
                                           wishimg=weakCell.GridImage.image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];
        
        UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [Tcell.WishButton setImage:image forState:UIControlStateNormal];

        find=[[UserDefaults class]IsFound:cobj.PName];
        if(!find)
            Tcell.WishButton.tintColor = [UIColor darkGrayColor];
        else
            cell.WishButton.tintColor = [UIColor redColor];

        Tcell.WishButton.tag=indexPath.row;
        Tcell.ShareButton.tag=indexPath.row;
        [Tcell.WishButton addTarget:self action:@selector(AddToWishList:)forControlEvents:UIControlEventTouchUpInside];
        [Tcell.ShareButton addTarget:self action:@selector(SendUrl:) forControlEvents:UIControlEventTouchUpInside];
        [self.glayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 160+Dlines)];
    
        return Tcell;
    }
    else{
        cell =  [collectionView dequeueReusableCellWithReuseIdentifier:AKCollectionCell forIndexPath:indexPath];
        
        CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[cell.ListItem font]}];
        CGFloat strikeWidth = textSize.width;
        Dlines=(strikeWidth/cell.ListItem.frame.size.width+1)*25+25;
        
        cell.ListItem.frame=CGRectMake(cell.ListItem.frame.origin.x,cell.ListItem.frame.origin.y, cell.ListItem.frame.size.width, Dlines);
        
        cell.ListItem.text=cobj.PName;
        cell.LPrice.text=[@"Rs " stringByAppendingString:cobj.Pprice];

        NSURL *Url = [NSURL URLWithString:[self ImgUrl:indexPath.row]];
        NSURLRequest *request = [NSURLRequest requestWithURL:Url];
        UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
        
        __weak CollectionCell *weakCell = cell;
        
        [cell.ListImage setImageWithURLRequest:request
                              placeholderImage:placeholderImage
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.ListImage.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];
        UIImage *image = [[UIImage imageNamed:@"WishIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [cell.WishButton setImage:image forState:UIControlStateNormal];

        find=[[UserDefaults class]IsFound:cobj.PName];
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
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    
    NSInteger lastSectionIndex = [self.collectionView numberOfSections] - 1;
    NSInteger lastRowIndex = [self.collectionView numberOfItemsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
        int pg=[_page intValue];
        _page=[NSNumber numberWithInt:pg+1];
        self.Loader.frame=CGRectMake(self.Loader.frame.origin.x, self.FilterView.frame.origin.y-50, self.Loader.frame.size.width, self.Loader.frame.size.height);
        self.Loader.hidden=NO;
        [self ApiParsing];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
   UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
   SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];

    if([tabindex integerValue]==0)
    {
        cobj=[allproducts objectAtIndex:indexPath.row];
        dvc.myobj=[allproducts objectAtIndex:indexPath.row];
        dvc.myobjImg=[[NSMutableArray alloc]initWithArray:[allproductimg objectAtIndex:indexPath.row]];
    }
    else
    {
        cobj=[popularproducts objectAtIndex:indexPath.row];
        dvc.myobj =[popularproducts objectAtIndex:indexPath.row];
        dvc.myobjImg =[[NSMutableArray alloc]initWithArray:[popularproductimg objectAtIndex:indexPath.row]];
    }

    dvc.title=cobj.PName;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.GLCollectionView.alwaysBounceVertical=NO;
    self.GLCollectionView.alwaysBounceHorizontal=NO;
}

-(void)AddToWishList:(UIButton *) sender
{   cobj=[[self loadArray] objectAtIndex:sender.tag];
    [[UserDefaults class]AddWhishList:cobj.PName :cobj.POfferPrice :[self ImgUrl:sender.tag]: self.view];
    cell.WishButton.tintColor = [UIColor redColor];
    Tcell.WishButton.tintColor = [UIColor redColor];
    [self.GLCollectionView reloadData];
}

-(void)SendUrl:(UIButton *) sender
{
    Categories *sup=[cobj.Supliers objectAtIndex:sender.tag];
    [[ShareUtility class]shareObject:@[sup.StoreUrl]];
}

- (IBAction)FilterButton:(id)sender {
    
    UIStoryboard *deals=[UIStoryboard storyboardWithName:@"GridList" bundle:nil];
    FiltersVC *dvc = [deals instantiateViewControllerWithIdentifier:@"test"];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void) ApiParsing
{
   [self activityInd];
   ProductViewController *pvc=(ProductViewController *)[self.navigationController topViewController];
    
   ApiParsing * mainVC = [[ApiParsing alloc] init];
   if([tabindex integerValue]==0)
    {
        [mainVC getAllProducts:^(NSMutableArray *response,NSMutableArray *img) {
            
            i=1;
            [self ReLoadArray:response andvalue:img];
             self.FilterView.hidden=NO;
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }
          catId:pvc.catId branchId:pvc.branchId page:_page
         ];
        
    }
    else
    {
        [mainVC getPopularProducts:^(NSMutableArray *response,NSMutableArray *img) {
            
            i=2;
            [self ReLoadArray:response andvalue:img];
             self.FilterView.hidden=YES;
            
            
        } failure:^(NSError *error, NSString *message) {
            NSLog(@"%@",error);
        }
          catId:pvc.catId branchId:pvc.branchId page:_page
         ];
    }
}

-(void) ReLoadArray:(NSMutableArray *)response andvalue:(NSMutableArray *)img
{
    if(allproducts.count==0 && i==1)
    {
        allproductimg=[img copy];
        allproducts=[response copy];
    }
    else if(popularproducts.count==0 && i==2)
    {
        popularproductimg=[img copy];
        popularproducts=[response copy];
    }
    else{
        
        NSArray *newArray,*newArrayimg;
        newArrayimg=[[NSArray alloc]init];
        newArray=[[NSArray alloc]init];
        if(i==1)
        {
            newArray=[allproductimg arrayByAddingObjectsFromArray:img];
            allproductimg=[newArray copy];
            newArrayimg=[allproducts arrayByAddingObjectsFromArray:response];
            allproducts=[newArrayimg copy];
        }
        else
        {
            newArray=[popularproductimg arrayByAddingObjectsFromArray:img];
            popularproductimg=[newArray copy];
            newArrayimg=[popularproducts arrayByAddingObjectsFromArray:response];
            popularproducts=[newArrayimg copy];
        }
    }

    self.Loader.hidden=YES;
    [activityIndicatorView stopAnimating];
    [self.collectionView reloadData];

}

-(void) activityInd
{
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.frame = self.Loader.bounds;
    [self.Loader addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

}

-(NSMutableArray *) loadArray
{
    if([tabindex integerValue]==0)
        return allproducts;
    else
        return popularproducts;
}

-(NSString *) ImgUrl:(NSInteger) ind
{
    if([tabindex integerValue]==0)
        return [[allproductimg objectAtIndex:ind]objectAtIndex:0];
    else
        return [[popularproductimg objectAtIndex:ind]objectAtIndex:0];
}

-(void) setLayout
{
    self.tLayout = [[TabledCollectionViewFlowLayout alloc] init];
    [self.tLayout setItemSize:CGSizeMake(self.collectionView.bounds.size.width, 180)];
    [self.tLayout setInterItemSpacingY:1.0];
    [self.glayout setInterItemSpacingY:1.0];
    [self.collectionView setScrollsToTop:YES];
    self.glayout = [[GridCollectionViewFlowLayout alloc] init];
    [self.collectionView setCollectionViewLayout:self.tLayout];
}

-(void) registerCell
{
    [self.collectionView registerNib:[UINib nibWithNibName:AKCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKCollectionCell];
    [self.collectionView registerNib:[UINib nibWithNibName:AKTabelledCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:AKTabelledCollectionCell];
}

@end
