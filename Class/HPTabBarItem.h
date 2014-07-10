//
//  HPTabBarItem.h
//  TabBarAutohide
//
//  Created by Huy Pham on 7/10/14.
//  Copyright (c) 2014 CoreDump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPTabBarItem : UIControl

/*

 - Item Height

*/

@property CGFloat itemHeight;

/*

 - Item title

*/

@property (nonatomic, copy) NSString *title;

/*

 - Array of imaga for tab bar item state selected, unselected and disable.
 
*/

@property (nonatomic, copy) UIImage *selectedImage;

@property (nonatomic, copy) UIImage *unselectedImage;

@property (nonatomic, copy) UIImage *disableImage;

/*
 
 - Badge attributes: Backgroud, badge count, textfont, text color.
 
 */

@property (nonatomic, copy) UIColor *badgeBackgroundColor;

@property (nonatomic) NSInteger badgeCount;

@property (nonatomic) UIFont *badgeTextFont;

@property (nonatomic) UIColor *badgeTextColor;


/*
 
 - Bar Item translucent
 
 */

@property (nonatomic) CGFloat translucent;

/*
 
 - The offset for the rectangle around the tab bar item's badge.

*/

@property (nonatomic) UIOffset badgePositionAdjustment;

@end
