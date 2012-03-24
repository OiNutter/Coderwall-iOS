//
//  ImageLoader.m
//  Coderwall
//
//  Created by Will on 24/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

+ (UIImage *) loadImageFromURL:(NSURL *)url usingCache:(BOOL)useCache
{
    NSURLRequestCachePolicy connectionCache = (useCache) ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReloadRevalidatingCacheData;
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:connectionCache
                                            timeoutInterval:60.0];
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&responseCode error:&error];
    if(responseCode)
        return [UIImage imageWithData:imageData];
    else
        return nil;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    NSCachedURLResponse *memOnlyCachedResponse =
    [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response
                                             data:cachedResponse.data
                                         userInfo:cachedResponse.userInfo
                                    storagePolicy:NSURLCacheStorageAllowedInMemoryOnly];
    return memOnlyCachedResponse;
}

@end
