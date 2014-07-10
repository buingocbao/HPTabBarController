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
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
    if (!(self = [super init])) {
        return nil;
    }
    [self setViewControllers:viewControllers];
    [self setTabBarHeight:49];
    return self;
}

/*
 
 - Init content view.
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

/*
 
 - Init tabBar.
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

/*
 
 - Set TabBar Height.
 
*/

- (void)setTabBarHeight:(CGFloat)tabBarHeight
{
    _tabBarHeight = tabBarHeight;
    [self.contentView setFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-_tabBarHeight)];
    [self.tabBar setFrame:CGRectMake(0, self.view.bounds.size.height-_tabBarHeight, self.view.bounds.size.width, _tabBarHeight)];
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
    
    if (self.tabBar.items) {
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:_selectedIndex];
        if (![item isSelected]) {
            [item setSelected:YES];
            [self.tabBar setSelectedItem:item];
        }
    }
    
}

/*
 
 - Set bar item selected image.
 
*/

- (void)setTabBarItemselectedImages:(NSArray *)tabBarItemselectedImages
{
    _tabBarItemselectedImages = [tabBarItemselectedImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_tabBarItemselectedImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setSelectedImage:[_tabBarItemselectedImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item unselected image.
 
 */

- (void)setTabBarItemUnselectedImages:(NSArray *)tabBarItemUnselectedImages
{
    _tabBarItemUnselectedImages = [tabBarItemUnselectedImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_tabBarItemUnselectedImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setUnselectedImage:[_tabBarItemUnselectedImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item disable image.
 
 */

- (void)setTabBarItemDisableImages:(NSArray *)tabBarItemDisableImages
{
    _tabBarItemDisableImages = [tabBarItemDisableImages copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_tabBarItemDisableImages count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setDisableImage:[_tabBarItemDisableImages objectAtIndex:i]];
    }
}

/*
 
 - Set bar item translucent values.
 
 */

- (void)setTabBarItemtranslucentValues:(NSArray *)tabBarItemtranslucentValues
{
    _tabBarItemtranslucentValues = [tabBarItemtranslucentValues copy];
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        if (i >= [_tabBarItemtranslucentValues count]) {
            return;
        }
        HPTabBarItem *item = [self.tabBar.items objectAtIndex:i];
        [item setTranslucent:[[_tabBarItemtranslucentValues objectAtIndex:i] floatValue]];
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
            
            if (_tabBarItemselectedImages) {
                if (i < [_tabBarItemDisableImages count]) {
                    [tabBarItem setSelectedImage:[_tabBarItemselectedImages objectAtIndex:i]];
                }
            }
            
            if (_tabBarItemUnselectedImages) {
                if (i < [_tabBarItemUnselectedImages count]) {
                    [tabBarItem setSelectedImage:[_tabBarItemUnselectedImages objectAtIndex:i]];
                }
            }
            
            if (_tabBarItemDisableImages) {
                if (i < [_tabBarItemDisableImages count]) {
                    [tabBarItem setSelectedImage:[_tabBarItemDisableImages objectAtIndex:i]];
                }
            }
            
        }
        if ([tabBarItems count] > 0) {
            [self.tabBar setItems:tabBarItems];
            [self setSelectedIndex:0];
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
 
 - Implement HPTabBar protocol

*/

- (void)didSelectedAtIndex:(NSInteger)index
{
    [self setSelectedIndex:index];
}

@end
