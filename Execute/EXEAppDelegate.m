//
//  EXEAppDelegate.m
//  Execute
//
//  Created by Scott MacDonald on 26/01/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

#import "EXEAppDelegate.h"
#import "EXEPlayViewController.h"

@implementation EXEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[EXEPlayViewController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
