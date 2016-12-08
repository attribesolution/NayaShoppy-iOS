//
//  UserReviews.h
//  nayashoppy
//
//  Created by Amerald on 07/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserReviews : NSObject
@property(nonatomic,strong) NSString * UserName;
@property(nonatomic,strong) NSURL * UserImg;
@property(nonatomic,strong) NSString * UserReview;
-(id) initWithName:name andUrl:url andReview:review;
-(id) initWithName:name andUrl:url;
@end
