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
#import "SDURLCache.h"
#import "ImageLoader.h"

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
    
    //set cache
    SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                                         diskCapacity:1024*1024*5 // 5MB disk cache
                                                             diskPath:[SDURLCache defaultCachePath]];
    [urlCache setMinCacheInterval:200];
    [NSURLCache setSharedURLCache:urlCache];
    
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
    [DejalBezelActivityView activityViewForView:self.window.rootViewController.view];
}

- (void)removeLoadingOverlay
{
    [DejalBezelActivityView removeView];
}

@end
