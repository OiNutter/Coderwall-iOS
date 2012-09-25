//
//  UIViewController+appDelegateUser.m
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import "UIViewController+appDelegateUser.h"
#import "AppDelegate.h"


@implementation UIViewController (appDelegateUser)

#pragma mark - Public Interface

- (User *)currentUser
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	return appDelegate.currentUser;
}

- (void)setCurrentUser:(User *)currentUser
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.currentUser = currentUser;
}

@end
