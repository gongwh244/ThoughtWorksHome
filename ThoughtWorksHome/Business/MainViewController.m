//
//  MainViewController.m
//  ThoughtWorksHome
//
//  Created by gong on 17/2/10.
//  Copyright © 2017年 gong. All rights reserved.
//

#import "MainViewController.h"
#import "ChatListViewController.h"
#import "FriendListViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChatListViewController *vc1 = [[ChatListViewController alloc] init];
    UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    [nc1.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    vc1.title = @"微信";
    nc1.view.backgroundColor = [UIColor whiteColor];
    nc1.tabBarItem.title = @"微信";
    
    FriendListViewController *vc2 = [[FriendListViewController alloc] init];
    UINavigationController *nc2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    [nc2.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    vc2.title = @"通讯录";
    nc2.view.backgroundColor = [UIColor whiteColor];
    nc2.tabBarItem.title = @"通讯录";
    
    DiscoverViewController *vc3 = [[DiscoverViewController alloc] init];
    UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    [nc3.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    vc3.title = @"发现";
    nc3.view.backgroundColor = [UIColor whiteColor];
    nc3.tabBarItem.title = @"发现";
    
    MeViewController *vc4 = [[MeViewController alloc] init];
    UINavigationController *nc4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    [nc4.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    vc4.title = @"我";
    nc4.view.backgroundColor = [UIColor whiteColor];
    nc4.tabBarItem.title = @"我";
    
    self.viewControllers = @[nc1,nc2,nc3,nc4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
