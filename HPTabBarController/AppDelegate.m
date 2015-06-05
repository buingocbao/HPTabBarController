//
//  AppDelegate.m
//  HPTabBarController
//
//  Created by Huy Pham on 6/5/15.
//  Copyright (c) 2015 Katana. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HPTabBarController.h"

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

@end
