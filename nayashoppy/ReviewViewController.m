//
//  ReviewViewController.m
//  nayashoppy
//
//  Created by Amerald on 11/11/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "ReviewViewController.h"
#import "MenuData.h"
#import "UserReviews.h"
#import "UIView+Toast.h"

@interface ReviewViewController ()
{
    CGRect oldFrame;
    MenuData *obj;
    NSMutableArray *myreview;
}
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    obj=[MenuData Items];
    if(obj.UserReviews.count==0)
    {
      _ReviewView.hidden=YES;
      _ReviewTextField.hidden=YES;
      [self.view makeToast:@"Please Sign In first to write your reviews"];
    }
    myreview=[[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self Notifications];
    [self TextFieldView];
    }

#pragma mark - UITableDelegate Method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
     return 240;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return myreview.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Review";
    
    ReviewsCell *cell = (ReviewsCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReviewsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UserReviews *urobj=[myreview objectAtIndex:indexPath.row];
    cell.ProfileName.text=urobj.UserName;
    cell.ProfileImg.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                 urobj.UserImg]];
    cell.Review.text=urobj.UserReview;
    
    cell.ReviewDate.text=[self date];
    return cell;

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectedBackgroundView:view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.ReviewsTabel.alwaysBounceVertical = NO;
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self userreview:textField.text];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self userreview:textField.text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.15 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y -= 260;
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.15 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = oldFrame.origin.y;
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void) Notifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) TextFieldView
{
    _ReviewTextField.delegate=self;
    oldFrame.origin.y= self.view.frame.origin.y;
    oldFrame.size.height= self.view.frame.size.height;
    [_ReviewTextField setLeftViewMode:UITextFieldViewModeAlways];
    _ReviewTextField.leftView= [self textImg];
}

-(void) userreview :(NSString *)review
{
    if(myreview.count==0)
    {
    UserReviews *robj=[obj.UserReviews objectAtIndex:0];
    UserReviews *userreview=[[UserReviews alloc]initWithName:robj.UserName andUrl:robj.UserImg andReview:review];
    [myreview addObject:userreview];
    [self.ReviewsTabel reloadData];
    }
}

-(NSString *) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(UIImageView *) textImg
{
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_info.png"]];
    arrow.frame = CGRectMake(0.0, 0.0, arrow.image.size.width+5.0, arrow.image.size.height);
    arrow.contentMode = UIViewContentModeCenter;
    return arrow;
}
@end
