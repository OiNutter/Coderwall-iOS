//
//  AvatarView.m
//  Coderwall
//
//  Created by Will Mckenzie on 12/03/2014.
//  Copyright (c) 2014 Bearded Apps. All rights reserved.
//

#import "AvatarView.h"

@interface AvatarView ()

- (void)setup;

@end

@implementation AvatarView

@synthesize image = _image;

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self setNeedsDisplay];
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
}

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 128.f, 128.f)];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    // Image rect
    CGRect imageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    // Start working with the mask
    CGColorSpaceRef maskColorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef mainMaskContextRef = CGBitmapContextCreate(NULL,
                                                            rect.size.width,
                                                            rect.size.height,
                                                            8,
                                                            rect.size.width,
                                                            maskColorSpaceRef,
                                                            0);
    CGContextRef shineMaskContextRef = CGBitmapContextCreate(NULL,
                                                             rect.size.width,
                                                             rect.size.height,
                                                             8,
                                                             rect.size.width,
                                                             maskColorSpaceRef,
                                                             0);
    CGColorSpaceRelease(maskColorSpaceRef);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor blackColor].CGColor);
    CGContextFillRect(mainMaskContextRef, rect);
    CGContextFillRect(shineMaskContextRef, rect);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor whiteColor].CGColor);
    
    // Create main mask shape
    CGContextMoveToPoint(mainMaskContextRef, 0, 0);
    CGContextAddEllipseInRect(mainMaskContextRef, imageRect);
    CGContextFillPath(mainMaskContextRef);
    // Create shine mask shape
    CGContextTranslateCTM(shineMaskContextRef, -(rect.size.width / 4), rect.size.height / 4 * 3);
    CGContextRotateCTM(shineMaskContextRef, -45.f);
    CGContextMoveToPoint(shineMaskContextRef, 0, 0);
    CGContextFillRect(shineMaskContextRef, CGRectMake(0,
                                                      0,
                                                      rect.size.width / 8 * 5,
                                                      rect.size.height));
    
    CGImageRef mainMaskImageRef = CGBitmapContextCreateImage(mainMaskContextRef);
    CGImageRef shineMaskImageRef = CGBitmapContextCreateImage(shineMaskContextRef);
    CGContextRelease(mainMaskContextRef);
    CGContextRelease(shineMaskContextRef);
    // Done with mask context
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    
    CGImageRef imageRef = CGImageCreateWithMask(self.image.CGImage, mainMaskImageRef);
    
    CGContextTranslateCTM(contextRef, 0, rect.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    CGContextSaveGState(contextRef);
    
    // Draw image
    CGContextDrawImage(contextRef, rect, imageRef);
    
    CGContextRestoreGState(contextRef);
    CGContextSaveGState(contextRef);
    
    // Clip to shine's mask
    CGContextClipToMask(contextRef, self.bounds, mainMaskImageRef);
    CGContextClipToMask(contextRef, self.bounds, shineMaskImageRef);
    CGContextSetBlendMode(contextRef, kCGBlendModeLighten);
    //CGContextDrawLinearGradient(contextRef, [self alphaGradient], CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
    
    CGImageRelease(mainMaskImageRef);
    CGImageRelease(shineMaskImageRef);
    CGImageRelease(imageRef);
    // Done with image
    
    CGContextRestoreGState(contextRef);
    
    CGContextSetLineWidth(contextRef, 0);
    //CGContextSetStrokeColorWithColor(contextRef, self.borderColor.CGColor);
    CGContextMoveToPoint(contextRef, 0, 0);
    CGContextAddEllipseInRect(contextRef, imageRect);
    // Drop shadow
    /*CGContextSetShadowWithColor(contextRef,
                                self.shadowOffset,
                                self.shadowBlur,
                                self.shadowColor.CGColor);*/
    CGContextStrokePath(contextRef);
    CGContextRestoreGState(contextRef);
}

@end
