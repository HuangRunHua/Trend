//
//  AppDelegate.m
//  trends
//
//  Created by Runhua Huang on 2024/5/2.
//

#import "AppDelegate.h"
#import "BilibiliTrendsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BilibiliTrendsViewController *bilibiliTrendsViewController = [[BilibiliTrendsViewController alloc] init];
    self.window.rootViewController = bilibiliTrendsViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
