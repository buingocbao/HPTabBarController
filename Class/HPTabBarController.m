//
//  HPTabBarController.m
//
//
//  Created by Huy Pham on 7/10/14.
//
//

#import "HPTabBarController.h"

#import "HPTabBarItem.h"
#import "HPTabBarMessage.h"

@interface HPTabBarController () <HPTabBarDelegate>

@property (nonatomic, weak) id activeObject;

@end

@implementation HPTabBarController {
    
    UIView *_contentView;
    BOOL isAnimating;
    CGFloat lastOffset;
    
    HPTabBarMessage *_messagePopup;
    NSInteger _messagePopupIndex;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers {
    
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    [self setViewControllers:viewControllers];
    return self;
}

- (instancetype)init {
    
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    
    _messagePopup = nil;
    _messagePopupIndex = -1;
    [self setTabBarHeight:44];
    [self setEnableDoucbleTouch:YES];
    [self setEnableTouchAgain:YES];
}

#pragma mark - Init View

/**
 
 - Init content view. <br/>
 - Content view contain view.
 
 */

- (UIView *)contentView {
    
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

- (HPTabBar *)tabBar {
    
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

- (void)setTabBarHeight:(CGFloat)tabBarHeight {
    
    _tabBarHeight = tabBarHeight;
    [self.contentView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [self.tabBar setFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-_tabBarHeight, CGRectGetWidth(self.view.bounds), _tabBarHeight)];
}

/*
 
 - Load view.
 - Add content and tabbar.
 
 */

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tabBar];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration {
    
    [self.tabBar setNeedsDisplay];
}

/*
 
 - Select intem at index.
 - When select item at index, the controller will present view.
 
 */

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    // Selected index out range.
    if (selectedIndex >= [self.viewControllers count]) {
        return;
    }
    
    // Remove message popup.
    if (selectedIndex == _messagePopupIndex) {
        [self removeMessagePopup];
    }
    
  
    UIViewController *viewController = [self.viewControllers objectAtIndex:selectedIndex];
  
    if (![viewController isKindOfClass:[NSNull class]]) {
      
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
        [self setSelectedViewController:viewController];
        [self.selectedViewController.view setFrame:self.contentView.bounds];
        [self addChildViewController:self.selectedViewController];
        [self.contentView addSubview:self.selectedViewController.view];
        [[self selectedViewController] didMoveToParentViewController:self];
    } else {
        [self.tabBar setSelectedItem:[self.tabBar.items objectAtIndex:_selectedIndex]];
    }
  
    if ([self.hPTabBarControllerDelegate respondsToSelector:@selector(hPTabBarControllerDidSelectedViewController:atIndex:)]) {
        [self.hPTabBarControllerDelegate hPTabBarControllerDidSelectedViewController:viewController atIndex:selectedIndex];
    }
}

/*
 
 - Set selected view controller.
 
 */

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    
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

- (void)setSelectedTabBarItemImages:(NSArray *)selectedTabBarItemImages {
    
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

- (void)setUnselectedTabBarItemImages:(NSArray *)unselectedTabBarItemImages {
    
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

- (void)setDisableTabBarItemImages:(NSArray *)disableTabBarItemImages {
    
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

- (void)setTranslucentTabBarItemValues:(NSArray *)translucentTabBarItemValues {
    
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

- (void)setViewControllers:(NSArray *)viewControllers {
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        _viewControllers = [viewControllers copy];
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.viewControllers count]; i++) {
            HPTabBarItem *tabBarItem = [[HPTabBarItem alloc] init];
            if (![[self.viewControllers objectAtIndex:i] isKindOfClass:[NSNull class]]) {
                [tabBarItem setTitle:[[self.viewControllers objectAtIndex:i] title]];
            }
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

- (void)setBagesCount:(NSInteger)count atIndex:(NSInteger)index {
    
    if (index > [self.tabBar.items count]) {
        return;
    }
    HPTabBarItem *item = [self.tabBar.items objectAtIndex:index];
    [item setBadgeCount:count];
}

- (void)showTabBarMessage:(NSString *)message
                     font:(UIFont *)font
                    color:(UIColor *)color
                  atIndex:(NSInteger)index {
    
    if (index > [self.tabBar.items count]) {
        return;
    }
    
    if (_messagePopup &&
        index == _messagePopupIndex &&
        [message isEqualToString:_messagePopup.messageString]) {
        return;
    }
    
    if (index == _selectedIndex) {
        return;
    }
    
    // Remove message popup.
    [self removeMessagePopup];
    HPTabBarMessage *messagePopup = [[HPTabBarMessage alloc] init];
    [messagePopup setFont:font];
    [messagePopup setPopupColor:color];
    [messagePopup setMessageString:message];
    
    CGFloat itemWith = CGRectGetWidth(self.view.bounds)/[self.tabBar.items count];
    
    CGFloat x = index*itemWith+itemWith/2.0;
    CGFloat y = CGRectGetHeight(self.view.bounds)-CGRectGetHeight(messagePopup.bounds)/2.0-_tabBarHeight;
    [messagePopup setCenter:CGPointMake(x, y)];
    
    [self.view addSubview:messagePopup];
    [UIView animateWithDuration:0.25
                     animations:^{
                         [messagePopup setAlpha:1];
                     }];
    _messagePopup = messagePopup;
    _messagePopupIndex = index;
    
    [messagePopup startAnimation];
}

- (void)removeMessagePopup {
    
    if (_messagePopup) {
        [_messagePopup stopAnimation];
        [UIView animateWithDuration:0.25
                         animations:^{
                             [_messagePopup setAlpha:0];
                         } completion:^(BOOL finished) {
                             [_messagePopup removeFromSuperview];
                             _messagePopup = nil;
                         }];
    }
}

/*
 
 - Set tab bar hidden with animated.
 
 */

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    
    // Is hidden or is animating.
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
    [self setPopupHiden:hidden];
}

- (void)setPopupHiden:(BOOL)hidden {
    
    CGFloat alpha = 1;
    if (hidden) {
        alpha = 0;
    }
    [UIView animateWithDuration:0.25
                     animations:^{
                         [_messagePopup setAlpha:alpha];
                     }];
}

/*
 
 - Set tab bar hidden without animated.
 
 */

- (void)setTabBarHidden:(BOOL)tabBarHidden {
    
    [self setTabBarHidden:tabBarHidden animated:NO];
}

#pragma mark - Implement HPTabBar protocol

/*
 
 - Implement HPTabBar protocol
 
 */

- (void)hPTabBarDidSelectedAtIndex:(NSInteger)index {
    
    [self setSelectedIndex:index];
}

- (void)hpTabBarDidDoubleTouchAtIndex:(NSInteger)index {
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if (self.isEnableDoubleTouch && [self.hPTabBarControllerDelegate respondsToSelector:@selector(hPTabBarControllerDidDoubleTouchViewController:atIndex:)]) {
        [self.hPTabBarControllerDelegate hPTabBarControllerDidDoubleTouchViewController:viewController atIndex:index];
    }
}

- (void)hpTabBarDidSelectedAgainAtIndex:(NSInteger)index {
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if (self.isEnableTouchAgain) {
        if ([self.hPTabBarControllerDelegate respondsToSelector:@selector(hPTabBarControllerDidTouchAgainViewController:atIndex:)]) {
            [self.hPTabBarControllerDelegate hPTabBarControllerDidTouchAgainViewController:viewController atIndex:index];
        }
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)viewController popToRootViewControllerAnimated:YES];
        }
    }
}

/*
 
 - Notification.
 
 */

- (void)registerScrollView:(UIScrollView *)scrollView {
    
    [scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
}

- (void)unregisterScrollView:(UIScrollView *)scrollView {
    
    [scrollView removeObserver:self
                    forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        return;
    }
    UIScrollView *scrollView  = (UIScrollView *)object;
    UIEdgeInsets edge = scrollView.contentInset;
    CGFloat contentOffset = scrollView.contentOffset.y+edge.top;
    
    if (![object isEqual:self.activeObject]) {
        [self setActiveObject:object];
        lastOffset = contentOffset;
        return;
    }
    
    CGFloat delta = lastOffset - contentOffset;
    // current > 0 to detect when scoll to top.
    if (contentOffset > 0 && delta < -2.0 && contentOffset < scrollView.contentSize.height-scrollView.bounds.size.height+edge.top) {
        [self setTabBarHidden:YES animated:YES];
    }else if (delta > 2.0 || (delta > 2.0 &&  contentOffset > scrollView.contentSize.height - scrollView.bounds.size.height+edge.bottom)) {
        [self setTabBarHidden:NO animated:YES];
    }
    lastOffset = contentOffset;
}

@end
