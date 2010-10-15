//
//  MaskedTextView.h
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

#import <UIKit/UIKit.h>

@interface MaskedTextView : UIView {
	CGImageRef alphaMask;
    CGContextRef drawingContext;
	NSString *text;
}

@property (nonatomic, retain) NSString *text;

- (CGImageRef)alphaMask;
- (CGContextRef) createOffscreenContext: (CGSize) size;

@end

