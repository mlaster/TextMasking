//
//  MaskedTextView.m
//  TextMasking
//
//  Created by Matt Gallagher on 2009/09/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "MaskedTextView.h"

@implementation MaskedTextView

@synthesize text;

- (id) initWithCoder: (NSCoder*) coder {
    if (self = [super initWithCoder: coder]) {
        self.backgroundColor = [UIColor clearColor];
        CGSize size = self.frame.size;
        drawingContext = [self createOffscreenContext:size];
        NSLog(@"drawingContext: %@", drawingContext);
    }

    return self;
}

- (void) dealloc {
    [super dealloc];
}

- (void)setText:(NSString *)newText {
	if (newText != text) {
		[text release];
		text = [newText retain];
		[self setNeedsDisplay];
	}
}

- (CGImageRef)alphaMask {
    if (alphaMask == nil) {
        NSLog(@"TRACE: Creating alphaMask");
        UIGraphicsPushContext(drawingContext);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToRect(context, [self frame]);
        CGRect rect = [self bounds];

        NSLog(@"rect: %@", NSStringFromCGRect(rect));
        NSLog(@"TRACE: Creating alphaMask in context %@", context);
        // Draw a dark gray background
        [[UIColor darkGrayColor] setFill];
        CGContextFillRect(context, rect);

        // Draw the text upside-down
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        [[UIColor whiteColor] setFill];
        [text drawInRect:rect withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0f]];
        CGContextRestoreGState(context);

        alphaMask = CGBitmapContextCreateImage(drawingContext);
        UIGraphicsPopContext();
    }

    return alphaMask;
}

- (CGContextRef)createOffscreenContext: (CGSize) size  {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 size.width,
                                                 size.height,
                                                 8,
                                                 size.width*4,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);

    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    NSLog(@"TRACE: Creating offscreenContext of size: %@", NSStringFromCGSize(size));
    return context;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
    NSLog(@"drawRect: context: %@", context);
//    UIGraphicsPushContext(drawingContext);
//    CGImageRef cgImage = CGBitmapContextCreateImage(drawingContext);
//    UIImage *uiImage = [[UIImage alloc] initWithCGImage:cgImage];

//    UIGraphicsPopContext();
//    CGImageRelease(cgImage);
//    [uiImage drawInRect: rect];
//    [uiImage release];
//	// Draw a dark gray background
//	[[UIColor darkGrayColor] setFill];
//    CGContextFillRect(context, rect);
//
//	// Draw the text upside-down
//	CGContextSaveGState(context);
//	CGContextTranslateCTM(context, 0, rect.size.height);
//	CGContextScaleCTM(context, 1.0, -1.0);
//	[[UIColor whiteColor] setFill];
//	[text drawInRect:rect withFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:72.0f]];
//	CGContextRestoreGState(context);
//
//	// Create an image mask from what we've drawn so far
//	CGImageRef alphaMask = CGBitmapContextCreateImage(context);

	// Draw a white background (overwriting the previous work)
	[[UIColor redColor] setFill];
	CGContextFillRect(context, rect);

    // Draw the image, clipped by the mask
	CGContextSaveGState(context);
//	CGContextClipToMask(context, rect, [self alphaMask]);
    NSLog(@"alphaMask: %@", [self alphaMask]);

//    [[UIColor greenColor] setFill];
	CGContextFillRect(context, rect);
    [[UIImage imageWithCGImage:[self alphaMask]] drawInRect:rect];

//	[[UIImage imageNamed:@"shuttle.jpg"] drawInRect:rect];
	CGContextRestoreGState(context);
//	CGImageRelease(alphaMask);
}

@end

