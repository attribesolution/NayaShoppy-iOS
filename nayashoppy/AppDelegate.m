 //
//  AppDelegate.m
//  nayashoppy
//
//  Created by Amerald on 03/10/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "UserReviews.h"
#import "singleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [Fabric with:@[[Crashlytics class]]];
    [Crashlytics sharedInstance].debugMode = YES;
    
    ApiParsing * mainVC = [[ApiParsing alloc] init];
   
    [mainVC getTopMenu:^(BOOL success) {
        
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
               
    } failure:^(NSError *error, NSString *message) {
        NSLog(@"%@",error);
    }];    
   
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
  
    [GIDSignIn sharedInstance].delegate = self;
    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [FBSDKButton class];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation];
   
   
    return handled || [[GIDSignIn sharedInstance] handleURL:url
                                         sourceApplication:sourceApplication
                                                annotation:annotation];
    

}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    singleton *obj=[singleton sharedManager];
    
    NSString *idToken = user.authentication.idToken;
    NSString *fullName = user.profile.name;

    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
    {
        NSUInteger dimension = round(100 * [[UIScreen mainScreen] scale]);
        NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
        UserReviews *robj=[[UserReviews alloc]initWithName:fullName andUrl:imageURL];
        [obj.UserReviews addObject:robj];
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SignIn" object:nil];
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {

    
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
