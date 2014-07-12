//
//  HPTabBarController.h
//  
//
//  Created by Huy Pham on 7/10/14.
//
//

#import <UIKit/UIKit.h>
#import "HPTabBar.h"

@protocol HPTabBarControllerDelegate

@optional

- (void)hPTabBarControllerDidSelectedViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

@end

@interface HPTabBarController : UIViewController


/*
 
 - HPTabBarDelegate.
 
 */

@property (nonatomic, weak) id <HPTabBarControllerDelegate> hPTabBarControllerDelegate;

/*
 
 - TabBar height.
 
 */

@property (nonatomic) CGFloat tabBarHeight;

/*
 
 - Selected item index.

 */

@property (nonatomic) NSUInteger selectedIndex;

/*

 - Selected Controller.
 
 */

@property (nonatomic, weak) UIViewController *selectedViewController;

/*
 
 - TabBar.
 
 */

@property (nonatomic, strong) HPTabBar *tabBar;

/*
 
 - Selected controller.
 
 */

@property (nonatomic, strong) NSArray *viewControllers;

/*
 
 - tabBar hidden.
 
 */

@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

/*
 
 - Custom init with array of view controller.
 
 */

- (instancetype)initWithViewControllers:(NSArray *)viewControllers;

/*
 
 - Array of item selected image.
 
*/

@property (nonatomic, strong) NSArray *selectedTabBarItemImages;

/*
 
 - Array of item unSelected image.
 
 */

@property (nonatomic, strong) NSArray *unselectedTabBarItemImages;

/*
 
 - Array of item disable image.
 
 */

@property (nonatomic, strong) NSArray *disableTabBarItemImages;

/*
 
 - Array of item translucent value.
 
 */

@property (nonatomic, strong) NSArray *translucentTabBarItemValues;


/*
 
 - Set badges count
 
*/

- (void)setBagesCount:(NSInteger)count atIndex:(NSInteger)index;

@end
