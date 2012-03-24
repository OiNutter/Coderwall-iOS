//
//  ImageLoader.h
//  Coderwall
//
//  Created by Will on 24/03/2012.
//  Copyright (c) 2012 Bearded Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageLoader : NSObject <NSURLConnectionDelegate>
{
    NSMutableData *receivedData;
}

+ (UIImage *) loadImageFromURL:(NSURL *)url usingCache:(BOOL) useCache;

@end
