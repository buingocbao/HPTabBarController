[![Build Status](https://travis-ci.org/huyphams/HPTabBarController.svg)](https://travis-ci.org/huyphams/HPTabBarController)[![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/HPTabBarController/badge.png)](http://cocoapods.org/?q=HPTabBarController)


HPTabBarController is an alternative of UITabBarController.

## Features

- [x] Custom tabbar icon, tabbar navigation.
- [x] Event double touch, single touch on tabbar icon.
- [x] Support auto hide.
- [x] Support null controller.
- [x] Support bages count and banner tooltip.

## Installation

#### CocoaPods

```ruby

pod "HPTabBarController", "~> 1.5.0"

```

#### Manual

 - Drag and drop Classes folder into your project.

## Usage

- Import header.

```objc

#import "HPTabBarController.h"

```

 - Customize

```objc

    HPTabBarController *tabBarController = [[HPTabBarController alloc] initWithViewControllers:viewControllers];
    // Set array selected tabbar icon images.
    [tabBarController setSelectedTabBarItemImages:selectedImages];
    // Set array unselected tabbar icon images.
    [tabBarController setUnselectedTabBarItemImages:unSelectedImages];
    // Set set bages count.
    [tabBarController setBagesCount:999 atIndex:0];

```

## Contact

- [duchuykun@gmail.com](http://huypham.me)

If you use/enjoy `HPTabBarController`, let me know!

## License

See the LICENSE file for more info.
