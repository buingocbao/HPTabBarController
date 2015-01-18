//
//  UIViewController+HPTabBarController.m
//  
//
//  Created by Huy Pham on 7/11/14.
//
//

#import "UIViewController+HPTabBarController.h"

@implementation UIViewController (HPTabBarController)

-(HPTabBarController *)hPTabBarController {
    
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if([parentViewController isKindOfClass:[HPTabBarController class]]){
            return (HPTabBarController *)parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

@end
