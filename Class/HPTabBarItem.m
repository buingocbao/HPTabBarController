//
//  HPTabBarItem.m
//  TabBarAutohide
//
//  Created by Huy Pham on 7/10/14.
//  Copyright (c) 2014 CoreDump. All rights reserved.
//

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#import "HPTabBarItem.h"

@implementation HPTabBarItem {

    UIOffset _imagePositionAdjustment;

}

- (instancetype)init {
    
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
    
}

/*
 
 - Init default value.
 
*/

- (void)commonInit {
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTranslucent:1.0];
    _badgeTextColor = [UIColor whiteColor];
    _badgeTextFont = [UIFont systemFontOfSize:12];
    _badgePositionAdjustment = UIOffsetZero;
    _badgeBackgroundColor = [UIColor redColor];
    _badgeCount = 0;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:self.superview.tintColor];
    } else {
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

/*
 
 - Draw barButton
 
*/

- (void)drawRect:(CGRect)rect {
    
    [self setAlpha:self.translucent];
    UIImage *image = nil;
    CGSize imageSize = CGSizeZero;
    CGSize frameSize = self.frame.size;
    
    if ([self isSelected]) {
        image = [self selectedImage];
    } else if (![self isEnabled]) {
        image = [self disableImage];
    } else {
        image = [self unselectedImage];
    }
    
    imageSize = image.size;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // DRAW IMAGE
    [image drawInRect:CGRectMake(frameSize.width / 2.0 - imageSize.width / 2.0,
                                 frameSize.height / 2.0 - imageSize.height / 2.0,
                                 imageSize.width,
                                 imageSize.height)];
    
    // DRAW BADGES
    if (self.badgeCount>0 || self.badgeSymbol) {
        CGSize badgeSize = CGSizeZero;
        NSString *badgeString = self.badgeSymbol;
        if (self.badgeCount>0) {
            badgeString = [NSString stringWithFormat:@"%ld", (long)self.badgeCount];
        }
        // Caculator badge string size
        if (SYSTEM_VERSION_LESS_THAN(@"7")) {
            badgeSize = [badgeString sizeWithFont:self.badgeTextFont constrainedToSize:CGSizeMake(frameSize.width, 20)];
        } else {
            badgeSize = [badgeString boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName: self.badgeTextFont}
                                                  context:nil].size;
        }
        
        if (badgeSize.width < badgeSize.height) {
            badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
        }
        
        CGRect badgeBackgroundFrame = CGRectMake(frameSize.width/2, 2.0, badgeSize.width + 2.0*2, badgeSize.height + 2.0*2);
        
        // Fill backgroud color
        
        if (self.badgeBackgroundColor) {
            CGContextSetFillColorWithColor(context, [self.badgeBackgroundColor CGColor]);
            CGContextFillEllipseInRect(context, badgeBackgroundFrame);
        }
        
        // Set fill text color
        CGContextSetFillColorWithColor(context, [self.badgeTextColor CGColor]);
        
        // Set badges text style
        NSMutableParagraphStyle *badgeTextStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        [badgeTextStyle setLineBreakMode:NSLineBreakByWordWrapping];
        [badgeTextStyle setAlignment:NSTextAlignmentCenter];
        
        // Set badges text font and text color
        NSDictionary *badgeTextAttributes = @{NSFontAttributeName: [self badgeTextFont],
                                              NSForegroundColorAttributeName: [self badgeTextColor],
                                              NSParagraphStyleAttributeName: badgeTextStyle };
        // Draw text
        if (SYSTEM_VERSION_LESS_THAN(@"7")) {
            [badgeString drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + 2.0,
                                                     CGRectGetMinY(badgeBackgroundFrame) + 2.0,
                                                     badgeSize.width, badgeSize.height)
                           withFont:self.badgeTextFont
                      lineBreakMode:NSLineBreakByTruncatingTail
                          alignment:NSTextAlignmentCenter];
        } else {
            [badgeString drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + 2.0,
                                           CGRectGetMinY(badgeBackgroundFrame) + 2.0,
                                           badgeSize.width,
                                           badgeSize.height)
                     withAttributes:badgeTextAttributes];
        }

    }

    CGContextRestoreGState(context);
}

- (void)setBadgeCount:(NSInteger)badgeCount {
    
    _badgeCount = badgeCount;
    if (_badgeCount<1) {
        _badgeSymbol = nil;
    }
    [self setNeedsDisplay];
}

- (void)setBadgeSymbol:(NSString *)badgeSymbol {
    
    _badgeSymbol = badgeSymbol;
    [self setNeedsDisplay];
}

@end
