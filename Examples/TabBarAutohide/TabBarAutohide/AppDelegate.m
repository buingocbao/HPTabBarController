//
//  AppDelegate.m
//  TabBarAutohide
//
//  Created by Huy Pham on 7/10/14.
//  Copyright (c) 2014 CoreDump. All rights reserved.
//

#import "AppDelegate.h"
#import "HPTabBarController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    NSMutableArray *selectedImages = [[NSMutableArray alloc] init];
    NSMutableArray *unSelectedImages = [[NSMutableArray alloc] init];

    for (int i=0; i<4; i++) {
        ViewController *viewController = [[ViewController alloc] init];
        if (i%2==0) {
            [viewController.view setBackgroundColor:[UIColor greenColor]];
        } else {
            [viewController.view setBackgroundColor:[UIColor purpleColor]];
        }
        [viewControllers addObject:viewController];
        [selectedImages addObject:[UIImage imageNamed:@"meoBlue"]];
        [unSelectedImages addObject:[UIImage imageNamed:@"meo"]];
    }
    
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    for (int i=0; i<4; i++) {
        UIViewController *view = [[UIViewController alloc] init];
        if (i%2==0) {
            [view.view setBackgroundColor:[UIColor whiteColor]];
        } else {
            [view.view setBackgroundColor:[UIColor grayColor]];
        }
        [viewController.navigationController pushViewController:view animated:NO];
        [selectedImages addObject:[UIImage imageNamed:@"meoBlue"]];
        [unSelectedImages addObject:[UIImage imageNamed:@"meo"]];
    }
    [viewControllers addObject:navigationController];
    HPTabBarController *tabBarController = [[HPTabBarController alloc] initWithViewControllers:viewControllers];
    [tabBarController setSelectedTabBarItemImages:selectedImages];
    [tabBarController setUnselectedTabBarItemImages:unSelectedImages];
    [tabBarController setBagesCount:999 atIndex:0];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
