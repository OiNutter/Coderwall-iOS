//
//  UIViewController+appDelegateUser.h
//  Coderwall
//
//  Created by modocache on 6/30/12.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "User.h"


@interface UIViewController (appDelegateUser)

@property (readwrite, nonatomic) User *currentUser;

@end
