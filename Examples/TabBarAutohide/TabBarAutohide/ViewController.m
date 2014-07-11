//
//  ViewController.m
//  TabBarAutohide
//
//  Created by Huy Pham on 7/11/14.
//  Copyright (c) 2014 CoreDump. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HPTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [button addTarget:self action:@selector(didWhenButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [button setCenter:self.view.center];
    [button setTitle:@"Hide tabBar" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didWhenButtonTouched:(id)sender
{
    if (self.hPTabBarController.tabBar.isHidden) {
        [self.hPTabBarController setTabBarHidden:NO animated:YES];
    } else {
        [self.hPTabBarController setTabBarHidden:YES animated:YES];
    }
}

@end
