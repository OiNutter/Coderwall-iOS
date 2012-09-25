//
//  AppDelegate.m
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright 2012 Bearded Apps. All rights reserved.
//


#import "AppDelegate.h"
#import "User.h"
#import "DejalActivityView.h"
#import "ImageLoader.h"

#if RUN_KIF_TESTS
#import "CoderwallTestController.h"
#endif


@interface AppDelegate ()
- (void)registerForNetworkNotifications;
- (void)showConnectionError:(NSNotification *)notification;
- (void)showHTTPResponseError:(NSNotification *)notification;
- (void)showLoadingOverlay;
- (void)removeLoadingOverlay;
- (void)loadCurrentUser;
@end


@implementation AppDelegate

@synthesize window = _window;
@synthesize currentUser = _currentUser;


#pragma mark - UIApplicationDelegate Protocol Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *svc = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [svc.viewControllers lastObject];
        svc.delegate = (id)navigationController.topViewController;
    }
    
    /*
    // Add Crittercism debugging
    [Crittercism initWithAppID: @"4fa9501fb093150f4300004c"
                        andKey:@"ne780aghaohlirxlkzxwjbyusitf"
                     andSecret:@"sbhf5kotnxxwscgapu39ddriz6ijvmpe"
         andMainViewController:self.window.rootViewController];
    */
    
    [self registerForNetworkNotifications];
    [self loadCurrentUser];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
#if RUN_KIF_TESTS
    [[CoderwallTestController sharedInstance] startTestingWithCompletionBlock:^{
        exit([[CoderwallTestController sharedInstance] failureCount]);
    }];
#endif
}


#pragma mark - Internal Methods

- (void)registerForNetworkNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(showConnectionError:)
                               name:@"ConnectionError"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(showHTTPResponseError:)
                               name:@"ResponseError"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(showLoadingOverlay)
                               name:@"Loading"
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(removeLoadingOverlay)
                               name:@"LoadingFinished"
                             object:nil];
}

- (void)showConnectionError:(NSNotification *)notification
{
    NSString *title = @"Error connecting to server, please try again in a few moments";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)showHTTPResponseError:(NSNotification *)notification
{
    NSString *message;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)notification.object;
    NSInteger code = [httpResponse statusCode];
    
    switch (code) {
        case 404:
            message = @"Sorry, there seems to be a problem finding the requested user. Please "
                      @"check you typed the username correctly and that the user exists.";
            break;            
        default:
            message = @"Sorry, we seem to be having problems loading the requested user. "
                      @"Please try again in a few minutes.";
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

- (void)loadCurrentUser
{
    // Load current user from NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults stringForKey:@"UserName"];

    if (userName != (id)[NSNull null] && userName.length > 0) {
        self.currentUser = [[User alloc] initWithUsername:userName];
    } else {
        self.currentUser = nil;
    }
}

@end
