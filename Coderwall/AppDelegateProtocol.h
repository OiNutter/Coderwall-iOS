//
//  AppDelegateProtocol.h
//  Coderwall
//
//  Created by Will on 18/02/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@protocol AppDelegateProtocol <NSObject>

- (User *) currentUser;
- (void) setCurrentUser:(User *) currentUser;
- (NSMutableArray *)refreshes;
- (void) setRefreshes:(NSMutableArray *)refreshes;

@end
