//
//  Alarm_ClockAppDelegate.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SCPlotCanvas;

@interface Alarm_ClockAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	
	IBOutlet SCPlotCanvas *plotCanvas; 
}

@property (assign) IBOutlet NSWindow *window;

@end
