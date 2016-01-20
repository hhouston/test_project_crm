//
//  AppDelegate.m
//  mongo_objc
//
//  Created by Hunter Houston on 12/20/15.
//  Copyright © 2015 Hunter Houston. All rights reserved.
//

#import "AppDelegate.h"
//#import <NAChloride/NAChloride.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // save to defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:@"hmhouston7" forKey:@"user_id_key"];

    // Right now, you can remove the seconds into the day if you want
    NSDate *today = [NSDate date];
    
    // All intervals taken from Google
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
    NSDate *thisWeek  = [today dateByAddingTimeInterval: -604800.0];
    NSDate *lastWeek  = [today dateByAddingTimeInterval: -1209600.0];
    
    // To get the correct number of seconds in each month use NSCalendar
    NSDate *thisMonth = [today dateByAddingTimeInterval: -2629743.83];
    NSDate *lastMonth = [today dateByAddingTimeInterval: -5259487.66];
    NSDate *more = [today dateByAddingTimeInterval:      -9000000.00];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
   
    NSString *dateStr = [dateFormatter stringFromDate:more];
    [defaults setObject:dateStr forKey:@"lastSync"];
//    NSLog(@"%@",dateStr);
    
    [defaults synchronize];
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
