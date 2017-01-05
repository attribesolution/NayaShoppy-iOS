//
//  NewArrivalVC.m
//  nayashoppy
//
//  Created by Amerald on 28/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "NewArrivalVC.h"
#import "singleton.h"

static NSString *NewArrivalCell=@"NewArrivalViewCell";
@interface NewArrivalVC ()
{
    singleton *obj;
    NSMutableArray *newArrivals,*newArrivalsImg;
}
@end

@implementation NewArrivalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    obj=[singleton sharedManager];
    newArrivals=[[NSMutableArray alloc]init];
    newArrivalsImg=[[NSMutableArray alloc]init];
    [self Parseapi];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.NewarrivalCv registerNib:[UINib nibWithNibName:NewArrivalCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NewArrivalCell];
        self.NewarrivalCv.backgroundColor=[UIColor whiteColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return newArrivals.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Categories *cobj=[newArrivals objectAtIndex:indexPath.row];
    obj.PCatId=cobj.PcatId;
    obj.PPrice=cobj.Pprice;
    obj.slug=cobj.Pslug;
    UIStoryboard *specifications=[UIStoryboard storyboardWithName:@"Specifications" bundle:nil];
    SpecificationsViewController *dvc = [specifications instantiateViewControllerWithIdentifier:@"Specifications"];
    SWRevealViewController *sv=self.revealViewController;
    dvc.myobj=cobj;
    dvc.myobjImg=[newArrivalsImg objectAtIndex:indexPath.row];
    [sv revealToggle:self];
    dvc.title=cobj.PName;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   [appDelegate.navController pushViewController:dvc animated:YES];
    appDelegate.navController.navigationBar.tintColor=[UIColor whiteColor];
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Categories *cobj=[newArrivals objectAtIndex:indexPath.row];
    NewArrivalViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:NewArrivalCell forIndexPath:indexPath];
    
    NSURL *Url = [NSURL URLWithString:[[newArrivalsImg objectAtIndex:indexPath.row]objectAtIndex:0]];
    NSURLRequest *request = [NSURLRequest requestWithURL:Url];
    UIImage *placeholderImage = [UIImage imageNamed:@"PlaceHolder"];
    
    __weak NewArrivalViewCell *weakCell = cell;
    
    [cell.NAimg setImageWithURLRequest:request
                                   placeholderImage:placeholderImage
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                weakCell.NAimg.image = image;
                                                [weakCell setNeedsLayout];
                                                
                                            } failure:nil];
    CGSize textSize = [cobj.PName sizeWithAttributes:@{NSFontAttributeName:[cell.NAProductName font]}];
    CGFloat strikeWidth = textSize.width;
    CGFloat Dlines=(strikeWidth/cell.NAProductName.frame.size.width+1)*25+25;
    
    cell.NAProductName.frame=CGRectMake(cell.NAProductName.frame.origin.x,cell.NAProductName.frame.origin.y, cell.NAProductName.frame.size.width, Dlines);

    [cell.NAProductName setText:cobj.PName];
    [cell.Price setText:[[@"Rs " stringByAppendingString:cobj.Pprice] stringByAppendingString:[[@" ( " stringByAppendingString:cobj.Discount] stringByAppendingString:@" % OFF)"]]];
   
   
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake(collectionView.frame.size.width/2-1, 150);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.NewarrivalCv.alwaysBounceVertical=NO;
}

-(void) Parseapi
{
    ApiParsing * mainVC = [[ApiParsing alloc] init];
    [mainVC getNewArrivals: ^(NSMutableArray *newArrival,NSMutableArray *newArrivalImg) {
        
        newArrivals=[newArrival copy];
        newArrivalsImg=[newArrivalImg copy];
        [self.NewarrivalCv reloadData];
        
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];
}
@end
