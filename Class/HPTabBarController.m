//
//  HPTabBarController.m
//  
//
//  Created by Huy Pham on 7/10/14.
//
//

#import "HPTabBarController.h"

#import "HPTabBarItem.h"

@interface HPTabBarController () <HPTabBarDelegate>

@end

@implementation HPTabBarController
{
    UIView *_contentView;
    BOOL isAnimating;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    [self setViewControllers:viewControllers];
    return self;
}

- (instancetype)init
{
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit
{
    [self setTabBarHeight:60];
    [self setEnableDoucbleTouch:YES];
}

#pragma mark - Init View

/**
 
 - Init content view. <br/>
 - Content view contain view.
 
*/

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
         UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|
         UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    }
    return _contentView;
}

/**
 
 - Init tabBar. <br/>
 - TabBar contain bar button.
 
*/

- (HPTabBar *)tabBar
{
    if (!_tabBar) {
        _tabBar = [[HPTabBar alloc] init];
        [_tabBar setDelegate:self];
        [_tabBar setBackgroundColor:[UIColor clearColor]];
        [_tabBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth|
         UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|
         UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin];
    }
    return _tabBar;
}

/**s
 
 - Set TabBar Height.
 
*/

- (void)setTabBarHeight:(CGFloat)tabBarHeight
{
    _tabBarHeight = tabBarHeight;
    [self.contentView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [self.tabBar setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-_tabBarHeight, CGRectGetWidth(self.view.bounds), _tabBarHeight)];
}

/*
 
 - Load view.
 - Add content and tabbar.
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tabBar];
}

/*
 
 - Select intem at index.
 - When select item at index, the controller will present view.
 
 */

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    // Selected index out range.
    if (selectedIndex >= [self.viewControllers count]) {
        return;
    }

    // Set selected index value
    _selectedIndex = selectedIndex;
    [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:selectedIndex]];
    
    // Remove current view controller.
    if ([self selectedViewController]) {
        [[self selectedViewController] willMoveToParentViewController:nil];
        [[[self selectedViewController] view] removeFromSuperview];
        [[self selectedViewController] removeFromParentViewController];
    }
    
    // Set present controller
    [self setSelectedViewController:[self.viewControllers objectAtIndex:selectedIndex]];
    [self.selectedViewController.view setFrame:self.contentView.bounds];
    [self addChildViewController:self.selectedViewController];
    [self.contentView addSubview:self.selectedViewController.view];
    [[self selectedViewController] didMoveToParentViewController:self];
}

/*
 
 - Set selected view controller.
 
 */

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    if ([self.viewControllers containsObject:selectedViewController]) {
        _selectedViewController = selectedViewController;
        NSInteger index = [self.viewControllers indexOfObject:selectedViewController];
        
        // Set selected index value
        _selectedIndex = index;
        [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:index]];
        
        // Remove current view controller.
        if ([self selectedViewController]) {
            [[self selectedViewController] willMoveToParentViewController:nil];
            [[[self selectedViewController] view] removeFromSuperview];
            [[self selectedViewController] removeFromParentViewController];
        }
        
        // Set present controller
        [self.selectedViewController.view setFrame:self.contentView.bounds];
        [self addChildViewController:selectedViewController];
        [self.contentView addSubview:selectedViewController.view];
        [selectedViewController didMoveToParentViewController:self];
    } else {
        _selectedViewController = nil;
    }
}

/*
 
 - Set bar item selected image.
 
*/

- (void)setSelectedTabBarItemImages:(NSArray *)selectedTabBarItemImages
{
    _selectedTabBarItemImages = [selectedTabBarItemImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_selectedTabBarItemImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setSelectedImage:[_selectedTabBarItemImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item unselected image.
 
 */

- (void)setUnselectedTabBarItemImages:(NSArray *)unselectedTabBarItemImages
{
    _unselectedTabBarItemImages = [unselectedTabBarItemImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_unselectedTabBarItemImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setUnselectedImage:[_unselectedTabBarItemImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item disable image.
 
 */

- (void)setDisableTabBarItemImages:(NSArray *)disableTabBarItemImages
{
    _disableTabBarItemImages = [disableTabBarItemImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_disableTabBarItemImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setDisableImage:[_disableTabBarItemImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item translucent values.
 
 */

- (void)setTranslucentTabBarItemValues:(NSArray *)translucentTabBarItemValues
{
    _translucentTabBarItemValues = [translucentTabBarItemValues copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_translucentTabBarItemValues count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setTranslucent:[[_translucentTabBarItemValues objectAtIndex:i] floatValue]];
    }
}

/*
 
 - Set view controller.
 - Init tab bar item.
 
*/

- (void)setViewControllers:(NSArray *)viewControllers
{
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.viewControllers count]; i++) {
            HPTabBarItem *tabBarItem = [[HPTabBarItem alloc] init];
            [tabBarItem setTitle:[[self.viewControllers objectAtIndex:i] title]];
            [tabBarItems addObject:tabBarItem];
            
            // Set tabBar image for state selected, unselected and disable.
            // It's necessary because you set array of image before you set viewcontrollers.
            
            if (_selectedTabBarItemImages) {
                if (i < [_selectedTabBarItemImages count]) {
                    [tabBarItem setSelectedImage:[_selectedTabBarItemImages objectAtIndex:i]];
                }
            }
            
            if (_unselectedTabBarItemImages) {
                if (i < [_unselectedTabBarItemImages count]) {
                    [tabBarItem setSelectedImage:[_unselectedTabBarItemImages objectAtIndex:i]];
                }
            }
            
            if (_disableTabBarItemImages) {
                if (i < [_disableTabBarItemImages count]) {
                    [tabBarItem setSelectedImage:[_disableTabBarItemImages objectAtIndex:i]];
                }
            }
            
            if (_translucentTabBarItemValues) {
                if (i < [_translucentTabBarItemValues count]) {
                    [tabBarItem setTranslucent:[[_translucentTabBarItemValues objectAtIndex:i] floatValue]];
                }
            }
            
        }
        if ([tabBarItems count] > 0) {
            [self.tabBar setItems:tabBarItems];
            [self hPTabBarDidSelectedAtIndex:0];
        }
    }
}

/*
 
 - Set bages count
 
*/

- (void)setBagesCount:(NSInteger)count atIndex:(NSInteger)index
{
    if (index > [self.tabBar.items count]) {
        return;
    }
    HPTabBarItem *item = [self.tabBar.items objectAtIndex:index];
    [item setBadgeCount:count];
}

/*
 
 - Set tab bar hidden with animated.
 
 */

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    // Detect if when tarBar is hidden of is animating.
    if (_tabBarHidden == hidden || isAnimating) {
        return;
    }
    _tabBarHidden = hidden;
    CGRect frame = self.tabBar.frame;
    CGRect viewFrame = self.view.frame;
    if (hidden) {
        frame.origin.x = 0;
        frame.origin.y = CGRectGetHeight(viewFrame);
    } else {
        frame.origin.y = CGRectGetHeight(viewFrame)-self.tabBarHeight;
    }
    if (frame.origin.y == self.tabBar.frame.origin.y) {
        return;
    }
    if (animated) {
        isAnimating = YES;
        [self.tabBar setHidden:NO];
        [UIView animateWithDuration:0.25 animations:^{
            [self.tabBar setFrame:frame];
        } completion:^(BOOL finished) {
            isAnimating = NO;
            [self.tabBar setHidden:_tabBarHidden];
        }];
    } else {
        [self.tabBar setFrame:frame];
        [self.tabBar setHidden:_tabBarHidden];
    }
}

/*
 
 - Set tab bar hidden without animated.
 
 */

- (void)setTabBarHidden:(BOOL)tabBarHidden
{
    [self setTabBarHidden:tabBarHidden animated:NO];
}

#pragma mark - Implement HPTabBar protocol

/*
 
 - Implement HPTabBar protocol

*/

- (void)hPTabBarDidSelectedAtIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if ([self.hPTabBarControllerDelegate respondsToSelector:@selector(hPTabBarControllerDidSelectedViewController:atIndex:)]) {
        [self.hPTabBarControllerDelegate hPTabBarControllerDidSelectedViewController:viewController atIndex:index];
    }
}

- (void)hpTabBarDidDoubleTouchAtIndex:(NSInteger)index
{
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if ([self.hPTabBarControllerDelegate respondsToSelector:@selector(hPTabBarControllerDidDoubleTouchViewController:atIndex:)]) {
        [self.hPTabBarControllerDelegate hPTabBarControllerDidDoubleTouchViewController:viewController atIndex:index];
    }
    if (self.isEnableDoubleTouch && [viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
    }
}

@end
