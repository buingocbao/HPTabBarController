//
//  HPTabBarItem.m
//  TabBarAutohide
//
//  Created by Huy Pham on 7/10/14.
//  Copyright (c) 2014 CoreDump. All rights reserved.
//

#import "HPTabBarItem.h"

@implementation HPTabBarItem {

    UIOffset _imagePositionAdjustment;

}

- (instancetype)init
{
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
    
}

/*
 
 - Init default value.
 
*/

- (void)commonInit
{
    [self setBackgroundColor:[UIColor blackColor]];
    [self setTranslucent:1.0f];
    _badgeTextColor = [UIColor whiteColor];
    _badgeTextFont = [UIFont systemFontOfSize:12];
    _badgePositionAdjustment = UIOffsetZero;
    _badgeBackgroundColor = [UIColor redColor];
    _badgeCount = 0;
}

/*
 
 - Draw barButton
 
*/

- (void)drawRect:(CGRect)rect
{
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
    
    imageSize = [image size];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // DRAW IMAGE
    
    [image drawInRect:CGRectMake(roundf(frameSize.width / 2 - imageSize.width / 2) + _imagePositionAdjustment.horizontal,
                                 roundf(frameSize.height / 2 - imageSize.height / 2) + _imagePositionAdjustment.vertical,
                                 imageSize.width,
                                 imageSize.height)];
    
    // DRAW BADGES
    
    if (self.badgeCount>0) {
        CGSize badgeSize = CGSizeZero;
        NSString *badgeString = [NSString stringWithFormat:@"%ld", (long)self.badgeCount];
        
        // Caculator badge string size
        badgeSize = [badgeString boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: self.badgeTextFont}
                                              context:nil].size;
        
        if (badgeSize.width < badgeSize.height) {
            badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
        }
        
        CGRect badgeBackgroundFrame = CGRectMake(frameSize.width/2, 2.0f, badgeSize.width + 2.0f*2, badgeSize.height + 2.0f*2);
        
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
        [badgeString drawInRect:CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + 2.0f,
                                           CGRectGetMinY(badgeBackgroundFrame) + 2.0f,
                                           badgeSize.width,
                                           badgeSize.height) withAttributes:badgeTextAttributes];

    }

    CGContextRestoreGState(context);
}

@end
