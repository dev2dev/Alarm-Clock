//
//  Alarm_ClockAppDelegate.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class SCPlotCanvas;
@class SCGraph;

@interface Alarm_ClockAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	SCGraph *graph;
	
	IBOutlet SCPlotCanvas *plotCanvas; 
	
	NSInteger count;
}


@property (assign) IBOutlet NSWindow *window;

@end
