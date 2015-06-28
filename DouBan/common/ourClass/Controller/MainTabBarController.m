//
//  MainTabBarController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MainTabBarController.h"
#import "ActivityListViewController.h"
#import "MovieListViewController.h"
#import "CinemaListViewController.h"
#import "UserTableViewController.h"
#import "Define.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //配置viewControllers
    [self configViewControllers];
}
-(void)configViewControllers
{
    //四大模块 活动 电影 影院 我的
    
    //活动
    ActivityListViewController *activityVC = [[ActivityListViewController alloc] init];
    UINavigationController *acNaVC = [[UINavigationController alloc] initWithRootViewController:activityVC];
    //title
    activityVC.title = @"活动";
    //图片
    acNaVC.tabBarItem.image = [UIImage imageNamed:kActivityBarImage];
    
    //电影
    MovieListViewController *movieVC = [[MovieListViewController alloc] init];
    UINavigationController *movieNaVC = [[UINavigationController alloc] initWithRootViewController:movieVC];
    //title
    movieVC.title = @"电影";
    //图片
    movieNaVC.tabBarItem.image = [UIImage imageNamed:kMovieBarImage];
    
    //影院
    CinemaListViewController *cinemaVC = [[CinemaListViewController alloc] init];
    UINavigationController *cinemaNaVC = [[UINavigationController alloc] initWithRootViewController:cinemaVC];
    //title
    cinemaVC.title = @"影院";
    //图片
    cinemaNaVC.tabBarItem.image = [UIImage imageNamed:kCinemaBarImage];
    
    //用户
    UserTableViewController *userVC = [[UserTableViewController alloc] init];
    UINavigationController *userNaVC = [[UINavigationController alloc] initWithRootViewController:userVC];
    //title
    userVC.title = @"我的";
    //图片
    userNaVC.tabBarItem.image = [UIImage imageNamed:kUserBarImage];
    
    //设置管理的viewControllers
    self.viewControllers = @[acNaVC,movieNaVC,cinemaNaVC,userNaVC];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
