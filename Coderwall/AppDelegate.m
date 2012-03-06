//
//  AppDelegate.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "DejalActivityView.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize currentUser;

- (id) init;
{
	return [super init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showConnectionError:) name:@"ConnectionError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHTTPResponseError:) name:@"ResponseError" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoadingOverlay) name:@"Loading" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeLoadingOverlay) name:@"LoadingFinished" object:nil];
    
    //load
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"UserName"];
    if(userName != (id)[NSNull null] && userName.length > 0)
        self.currentUser = [[User alloc] initWithUsername:userName];
    else 
        self.currentUser = Nil;
    return YES;
}

- (void)showConnectionError:(NSNotification *)notification
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error connecting to server, please try again in a few moments"
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)showHTTPResponseError:(NSNotification *)notification
{
    NSString *message;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)notification.object;
    int code = [httpResponse statusCode];
    
    switch (code) {
        case 404:
            message = [[NSString alloc] initWithString:@"Sorry, there seems to be a problem finding the requested user. Please check you typed the username correctly and that the user exists"];
            break;            
        default:
            message = [[NSString alloc] initWithString:@"Sorry, we seem to be having problems loading the requested user. Please try again in a few minutes"];
            break;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)showLoadingOverlay
{
    NSLog(@"Show Loading");
    [DejalBezelActivityView activityViewForView:self.window.rootViewController.view];
}

- (void)removeLoadingOverlay
{
    NSLog(@"Remove Loading");
    [DejalBezelActivityView removeView];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
