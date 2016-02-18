//
//  AppDelegate.m
//  RGTest
//
//  Created by Sapa Denys on 15.02.16.
//  Copyright © 2016 Sapa Denys. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[MagicalRecord setupCoreDataStack];
	return YES;
}

@end
