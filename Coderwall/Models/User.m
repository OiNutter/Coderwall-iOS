//
//  User.m
//  Coderwall
//
//  Created by Will on 17/02/2012.
//  Copyright 2012 Bearded Apps. All rights reserved.
//

#import "User.h"
#import "SBJson.h"

@implementation User

@synthesize userName;
@synthesize name;
@synthesize location;
@synthesize title;
@synthesize company;
@synthesize thumbnail;
@synthesize endorsements;
@synthesize badges;
@synthesize accomplishments;
@synthesize stats;
@synthesize specialities;

- (id)init
{
    return [self initWithUsername:@""];
}

- (id) initWithUsername:(NSString *) user
{
    self = [super init];
    
    [self load:user];
    
    return self;
}

- (void) load:(NSString *) user
{
    NSLog(@"Loading...");
    NSString *urlString = [NSString stringWithFormat:@"http://coderwall.com/%@.json?full=true", user];
	NSString *response = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
    [self setDetails:[response JSONValue]];    
}

- (void) setDetails:(NSDictionary *) details
{
    self.userName = [details objectForKey:@"username"];
    self.name = [details objectForKey:@"name"];
    self.location = [details objectForKey:@"location"];
    self.title = [details objectForKey:@"title"];
    self.company = [details objectForKey:@"company"];
    self.thumbnail = [details objectForKey:@"thumbnail"];
    self.endorsements = [details objectForKey:@"endorsements"];
    self.badges = [details objectForKey:@"badges"];
    self.accomplishments = [details objectForKey:@"accomplishments"];
    self.stats = [details objectForKey:@"stats"];
    self.specialities = [details objectForKey:@"specialities"];
}

- (UIImage *) getAvatar
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?s=200",self.thumbnail]];
    return [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
}

@end
