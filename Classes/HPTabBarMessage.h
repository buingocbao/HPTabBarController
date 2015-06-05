//
//  HPTabBarMessage.h
//  Pods
//
//  Created by Huy Pham on 1/19/15.
//
//

#import <UIKit/UIKit.h>

@interface HPTabBarMessage : UIView

@property (nonatomic, copy) NSString *messageString;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, copy) UIColor *popupColor;

- (void)startAnimation;
- (void)stopAnimation;

@end
