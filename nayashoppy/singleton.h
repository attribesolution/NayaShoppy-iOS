//
//  singleton.h
//  nayashoppy
//
//  Created by Amerald on 20/12/2016.
//  Copyright © 2016 attribe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singleton : NSObject

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end
