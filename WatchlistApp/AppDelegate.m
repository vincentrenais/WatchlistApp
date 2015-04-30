//
//  AppDelegate.m
//  WatchlistApp
//
//  Created by Vincent Renais on 2015-04-27.
//  Copyright (c) 2015 Vincent Renais. All rights reserved.
//

#import "AppDelegate.h"
#import "WatchlistTVC.h"
#import "AddMovieVC.h"
#import "DiscoverVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // WATCHLIST TABLE VIEW CONTROLLER
    
    // Create a Table ViewController for the movies to watch
    WatchlistTVC *watchlistTVC = [[WatchlistTVC alloc]initWithStyle:UITableViewStylePlain];
    
    // Create a NavigationController for the movies to watch Table ViewController
    UINavigationController *watchlistNC = [[UINavigationController alloc]initWithRootViewController:watchlistTVC];
    
    
    // ADD-A-MOVIE VIEW CONTROLLER
    
    AddMovieVC *addMovieVC = [[AddMovieVC alloc]init];
    
    addMovieVC.view.backgroundColor = [UIColor whiteColor];
    
    // Create a NavigationController for the Add movie View ViewController
    
    UINavigationController *addMovieNC = [[UINavigationController alloc]initWithRootViewController:addMovieVC];
    
    
    // SUGGESTIONS VIEW CONTROLLER
    
    DiscoverVC *discoverVC = [[DiscoverVC alloc]init];
    
    discoverVC.view.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *discoverNC = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    
    
    // Create a tab bar navigation
    UITabBarController *tabBarNav = [[UITabBarController alloc]init];
    
    // Add the ViewControllers to the tab bar
    tabBarNav.viewControllers = @[discoverNC, watchlistNC, addMovieNC];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    self.window.rootViewController = tabBarNav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
