//
//  TextMaskingViewController.m
//  TextMasking
//
//  Created by Matt Gallagher on 2009/09/08.
//  Copyright Matt Gallagher 2009. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "TextMaskingViewController.h"
#import "MaskedTextView.h"

@implementation TextMaskingViewController

@synthesize maskedTextView;

- (void)fire:(NSTimer *)aTimer
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateStyle:NSDateFormatterNoStyle];
	[dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
	maskedTextView.text = [dateFormatter stringFromDate:[NSDate date]];

}

- (void)clearTimer
{
	[tickTimer invalidate];
	tickTimer = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
//	[self clearTimer];

    maskedTextView.text = @"Hello, world.";

//	[self fire:nil];
//	tickTimer =
//		[NSTimer
//			scheduledTimerWithTimeInterval:1.0
//			target:self
//			selector:@selector(fire:)
//			userInfo:nil
//			repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[self clearTimer];
}

- (void)dealloc
{
	[self clearTimer];
    [maskedTextView release];
	[super dealloc];
}

@end
