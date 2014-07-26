//
//  HPTabBar.h
//  
//
//  Created by Huy Pham on 7/10/14.
//
//

#import <UIKit/UIKit.h>

#import "HPTabBarItem.h"

@protocol HPTabBarDelegate

@required

- (void)hPTabBarDidSelectedAtIndex:(NSInteger)index;

- (void)hpTabBarDidDoubleTouchAtIndex:(NSInteger)index;

@end

@interface HPTabBar : UIView

/*
 
 - List of barbutton Item.

*/

@property (nonatomic, copy) NSArray *items;

/*
 
 - Selected TabBar button.
 
 */

@property (nonatomic, weak) HPTabBarItem *selectedItem;


/*
 
 - TabBar delegate.
 
 */

@property (nonatomic, weak) id <HPTabBarDelegate> delegate;


@end
