//
//  ShareUtility.m
//  YapJobs
//
//  Created by kashif Saeed on 01/12/2016.
//  Copyright © 2016 YapJobs Limited. All rights reserved.
//

#import "ShareUtility.h"

@implementation ShareUtility

+(void)shareObject:(id)objectsToShare{
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate.navController presentViewController:activityVC animated:YES completion:nil];
}
@end
