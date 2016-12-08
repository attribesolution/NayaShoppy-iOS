//
//  UserReviews.m
//  nayashoppy
//
//  Created by Amerald on 07/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "UserReviews.h"

@implementation UserReviews
-(id) initWithName:name andUrl:url andReview:review
{
    self=[super init];
    {
        _UserName=name;
        _UserImg=url;
        _UserReview=review;
    }
    return self;
}
-(id) initWithName:name andUrl:url
{
    self=[super init];
    {
        _UserName=name;
        _UserImg=url;
    }
    return self;
}
@end
