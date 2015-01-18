//
//  HPTabBarMessage.m
//  Pods
//
//  Created by Huy Pham on 1/19/15.
//
//

#import "HPTabBarMessage.h"

@implementation HPTabBarMessage {
    
    UILabel *_message;
    UIView *_backgound;
    BOOL up;
    BOOL stop;
}

- (instancetype)init {
    
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    
    up = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:[self background]];
    [self addSubview:[self message]];
    [self setAlpha:0];
}

- (UILabel *)message {
    
    if (!_message) {
        _message = [[UILabel alloc] init];
        [_message setNumberOfLines:0];
        [_message setTextColor:[UIColor whiteColor]];
        [_message setBackgroundColor:[UIColor clearColor]];
    }
    return _message;
}

- (UIView *)background {
    
    if (!_backgound) {
        _backgound = [[UIView alloc] init];
        [_backgound setBackgroundColor:[UIColor blueColor]];
        [_backgound.layer setCornerRadius:5];
    }
    return _backgound;
}

- (void)setMessageString:(NSString *)messageString {
    
    _messageString = messageString;
    [[self message] setText:_messageString];
    [self reLayout];
}

- (void)setFont:(UIFont *)font {
    
    _font = font;
    [[self message] setFont:font];
    [self reLayout];
}

- (void)reLayout {
    
    [[self message] setFrame:CGRectMake(10, 10, 100, 0)];
    [_message sizeToFit];
    [self setFrame:CGRectMake(0, 0, 120, CGRectGetHeight(_message.bounds)+30)];
    [[self background] setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-10)];
}

- (void)setPopupColor:(UIColor *)popupColor {
    
    _popupColor = popupColor;
    [[self background] setBackgroundColor:[_popupColor copy]];
    [self reLayout];
}

- (void)startAnimation {
    
    if (stop) {
        return;
    }
    __block CGRect frame = self.frame;
    if (up) {
        frame.origin.y -=10;
    } else {
        frame.origin.y +=10;
    }
    up = !up;
    [UIView animateWithDuration:0.5 animations:^{
        [self setFrame:frame];
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self performSelector:@selector(startAnimation)
                       withObject:nil
                       afterDelay:0
                          inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];

        }
    }];
}

- (void)stopAnimation {
    
    stop = YES;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint   (ctx, CGRectGetWidth(rect)/2.0-10, CGRectGetHeight(rect)-10.2);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(rect)/2.0+10, CGRectGetHeight(rect)-10.2);
    CGContextAddLineToPoint(ctx, CGRectGetWidth(rect)/2.0, CGRectGetHeight(rect));
    CGContextClosePath(ctx);
    
    if (!_popupColor) {
        CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    } else {
        CGContextSetFillColorWithColor(ctx, _popupColor.CGColor);
    }
    CGContextFillPath(ctx);
}

@end
