//
//  AppDelegate.m
//  SunShine
//
//  Created by udhaykanthd on 5/27/15.
//  Copyright (c) 2015 udhaykanthd. All rights reserved.
//

#import "AppDelegate.h"
#import "WeatherListViewController.h"
#import "WeatherShared.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    WeatherListViewController *listVC = [[WeatherListViewController alloc] init];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:listVC];
    PRINT_CONSOLE_LOG(nil);
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor yellowColor]];
    /*
     NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset:CGSizeMake(0, 1)];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];
     */
    //[self.navigationController.navigationBar setTranslucent:YES];
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@" "] forBarMetrics:UIBarMetricsDefault];
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@" "]];
    
    /* 
     UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    
    NSArray *actionButtonItems = @[shareItem, cameraItem];
    self.navigationController.navigationItem.rightBarButtonItems = actionButtonItems;
     */
    
     

//    var doneButtonAsLeftArrow = UIBarButtonItem(image: UIImage(named: "LeftArrow24x24.png"), style: .Plain, target: self, action: "doneButtonPushed")
//    self.view.navigationItem?.setLeftBarButtonItem(doneButtonAsLeftArrow)
    

    
   /*
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings-50.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openSettingView)];
    [self.navigationController.navigationItem setRightBarButtonItem:settingItem];
  */




    self.window.rootViewController = self.navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSString *units = [[NSUserDefaults standardUserDefaults]objectForKey:UNITS_PREFERENCE];

    if (nil != units) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:UNITS_PREFERENCE];
    }
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
