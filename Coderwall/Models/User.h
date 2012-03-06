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
    NSString *userName;
    NSString *name;
    NSString *location;
    NSString *title;
    NSString *company;
    NSString *thumbnail;
    NSNumber *endorsements;
    NSArray *badges;
    NSArray *accomplishments;
    NSArray *stats;
    NSArray *specialities;
    NSMutableData *receivedData;
    
}

@property NSString *userName;
@property NSString *name;
@property NSString *location;
@property NSString *title;
@property NSString *company;
@property NSString *thumbnail;
@property NSNumber *endorsements;
@property NSArray *badges;
@property NSArray *accomplishments;
@property NSArray *stats;
@property NSArray *specialities;

- (id) initWithUsername:(NSString *) userName;
- (void) load:(NSString *) userName;
- (void) setDetails:(NSDictionary *) details;
- (UIImage *) getAvatar;

@end
