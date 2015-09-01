//
//  AppDelegate.m
//  BigEyes
//
//  Created by mac chen on 15/7/27.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageListViewController.h"
#import "TTMenuViewController.h"
#import "TTLoginViewController.h"


@interface AppDelegate ()
{
  RESideMenu *sideMenuViewController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self customizeInterface];
    [self saveUserInformation];
    
    //注册Mob短信验证

    [SMS_SDK registerApp:UMAPPKEY withSecret:UMAPPSecret];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    ImageListViewController *imageVC = [[ImageListViewController alloc]init];
//    imageVC.showNavi = YES;
//    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:imageVC];
//    TTMenuViewController  *menuVC = [[TTMenuViewController alloc]init];
//    sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:navVC leftMenuViewController:menuVC rightMenuViewController:nil];
//    sideMenuViewController.panGestureEnabled = YES;
//    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"sideground"];
//    self.window.rootViewController = sideMenuViewController;
    TTLoginViewController *loginVC = [[TTLoginViewController alloc]init];
    loginVC.showNavi = NO;
    loginVC.haveBack = NO;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

    // Override point for customization after application launch.
    return YES;
}


/**
 *  先留着，做测试用，以后登录再改
 */
- (void)saveUserInformation {
    [TTUserDefaultTool setObject:@"bfa443173b16f18371120a95c3ee3c60" forKey:TTSessionid];
    [TTUserDefaultTool setObject:@"11" forKey:TTuid];
    [TTUserDefaultTool setObject:@"chenqitao" forKey:TTname];
   
 
}



#pragma mark - 自定义界面
- (void)customizeInterface {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:229.0/255.0 green:80.0/255.0 blue:76.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setBarTintColor:TTColor(255, 0, 19, 1)];
  
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName,[UIFont fontWithName:@"Lithos Pro" size:20.0], NSFontAttributeName, nil]];
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
