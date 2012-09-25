//
//  User.m
//  Coderwall
//
//  Created by Will on 17/02/2012.
//  Copyright 2012 Bearded Apps. All rights reserved.
//

#import "User.h"
#import "SBJson.h"
#import "ImageLoader.h"

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
    
    [self load:user withCache:YES];
    
    return self;
}

- (void) load:(NSString *) user withCache:(BOOL) useCache
{
    NSURLRequestCachePolicy connectionCache = (useCache) ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReloadRevalidatingCacheData;
    NSString *urlString = [NSString stringWithFormat:@"http://coderwall.com/%@.json?full=true", user];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString ]
                                                cachePolicy:connectionCache
                                            timeoutInterval:60.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    if (connection) {
        receivedData = [NSMutableData data];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Loading" object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionError" object:connection];        
    }
}

- (void) refresh
{
    [self load:self.userName withCache:NO];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    if(code == 200){
        [receivedData setLength:0];
    } else {
        [connection cancel];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadingFinished" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ResponseError" object:response];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    [self setDetails:[response JSONValue]];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadingFinished" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectionError" object:connection];
}

- (void) setDetails:(NSDictionary *) details
{
    @try{
        self.userName = [details objectForKey:@"username"] ? [details objectForKey:@"username"] : @"";
        self.name = [details objectForKey:@"name"] ? [details objectForKey:@"name"] : @"";
        self.location = [details objectForKey:@"location"] ? [details objectForKey:@"location"]: nil;
        self.title = [details objectForKey:@"title"] ? [details objectForKey:@"title"] : nil;
        self.company = [details objectForKey:@"company"] ? [details objectForKey:@"company"] : nil;
        self.thumbnail = [details objectForKey:@"thumbnail"] ? [details objectForKey:@"thumbnail"] : nil;
        self.endorsements = [details objectForKey:@"endorsements"] ? [details objectForKey:@"endorsements"] : 0;
        self.badges = [details objectForKey:@"badges"] ? [details objectForKey:@"badges"] : nil;
        self.accomplishments = [details objectForKey:@"accomplishments"] ? [details objectForKey:@"accomplishments"] : nil;
        self.stats = [details objectForKey:@"stats"] ? [details objectForKey:@"stats"] : nil;
        self.specialities = [details objectForKey:@"specialities"] ? [details objectForKey:@"specialities"] : nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadingFinished" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UserChanged" object:self];
    } 
    @catch(NSException *e)
    {
        NSLog(@"Exception: %@", e);
    }
    
}

- (UIImage *) getAvatar
{
    int size = 200;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
        size = 400;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?s=%d",self.thumbnail,size]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
                                            timeoutInterval:60.0];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&responseCode error:&error];
    if(responseCode)
        return [UIImage imageWithData:imageData];
    else
        return [UIImage imageNamed:@"defaultavatar.png"];
}

@end
