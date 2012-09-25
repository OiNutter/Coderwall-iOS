//
//  User.h
//  Coderwall
//
//  Created by Will on 17/02/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject <NSURLConnectionDelegate>
{
    
    @private
    NSString *__strong userName;
    NSString *__strong name;
    NSString *__strong location;
    NSString *__strong title;
    NSString *__strong company;
    NSString *__strong thumbnail;
    NSNumber *__strong endorsements;
    NSArray *__strong badges;
    NSArray *__strong accomplishments;
    NSArray *__strong stats;
    NSArray *__strong specialities;
    NSMutableData *receivedData;
    
}

@property (strong) NSString *userName;
@property (strong) NSString *name;
@property (strong) NSString *location;
@property (strong) NSString *title;
@property (strong) NSString *company;
@property (strong) NSString *thumbnail;
@property (strong) NSNumber *endorsements;
@property (strong) NSArray *badges;
@property (strong) NSArray *accomplishments;
@property (strong) NSArray *stats;
@property (strong) NSArray *specialities;

- (id) initWithUsername:(NSString *) userName;
- (void) load:(NSString *) userName withCache:(BOOL) useCache;
- (void) refresh;
- (void) setDetails:(NSDictionary *) details;
- (UIImage *) getAvatar;

@end
