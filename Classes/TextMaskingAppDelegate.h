//
//  TextMaskingAppDelegate.h
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

#import <UIKit/UIKit.h>

@class TextMaskingViewController;

@interface TextMaskingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TextMaskingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TextMaskingViewController *viewController;

@end

