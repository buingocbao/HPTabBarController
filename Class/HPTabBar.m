//
//  HPTabBar.m
//  
//
//  Created by Huy Pham on 7/10/14.
//
//

#import "HPTabBar.h"

@implementation HPTabBar

- (instancetype)init
{
    if (!(self = [super init])) {
        return nil;
    }
    [self setBackgroundColor:[UIColor clearColor]];
    return self;
}

/*
 
 - Set tabBar Items
 
*/

- (void)setItems:(NSArray *)items
{
    if (items && [items isKindOfClass:[NSArray class]]) {
        for (HPTabBarItem *item in items) {
            [item removeFromSuperview];
        }
        _items = [items copy];
        for (int i = 0; i < [_items count]; i++) {
            HPTabBarItem *item = [_items objectAtIndex:i];
            [item addTarget:self action:@selector(didSelectedAtIndex:) forControlEvents:UIControlEventTouchDown];
            [item addTarget:self action:@selector(didDoubleTouchAtIndex:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
            [self addSubview:item];
        }
    }
}

/*
 
 - Relayout tabBar Item.
 
*/

- (void)layoutSubviews
{
    if ([self.items count]<1) {
        return;
    }
    CGFloat itemHeight = self.frame.size.height;
    CGFloat itemWidth = self.frame.size.width/[self.items count];
    for (int i = 0; i < [self.items count]; i++) {
        HPTabBarItem *item = [self.items objectAtIndex:i];
        [item setFrame:CGRectMake(itemWidth*i, 0, itemWidth, itemHeight)];
    }
}

/*
 
 - Call when touch down bar item
 
*/

- (void)didSelectedAtIndex:(id)sender
{
    HPTabBarItem *item = (HPTabBarItem *)sender;
    NSInteger index  = [self.items indexOfObject:item];
    if (self.selectedItem) {
        if (self.selectedItem == sender) {
            [self.delegate hpTabBarDidSelectedAgainAtIndex:index];
            return;
        }
        [self.selectedItem setSelected:NO];
    }
    [item setSelected:YES];
    [self setSelectedItem:item];
    [self.delegate hPTabBarDidSelectedAtIndex:index];
}

-(void)didDoubleTouchAtIndex:(id)sender withEvent:(UIEvent*)event {
    
    HPTabBarItem *item = (HPTabBarItem *)sender;
    NSInteger index  = [self.items indexOfObject:item];
    UITouch* touch = [[event allTouches] anyObject];
    if ([touch tapCount] == 2) {
        [self.delegate hpTabBarDidDoubleTouchAtIndex:index];
    }
}

- (void)setSelectedItem:(HPTabBarItem *)selectedItem
{
    if (_selectedItem == selectedItem) {
        return;
    }
    [_selectedItem setSelected:NO];
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}

@end
