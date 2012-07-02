//
//  AppDelegate.h
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright 2012 Bearded Apps. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "User.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) User *currentUser;

@end
