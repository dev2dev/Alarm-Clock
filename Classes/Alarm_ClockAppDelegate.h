//
//  Alarm_ClockAppDelegate.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCRemoteAccelerometer.h"

@class SCPlotCanvas;
@class SCGraph;

@interface Alarm_ClockAppDelegate : NSObject <NSApplicationDelegate, SCRemoteAccelrometerDelegate> {
    NSWindow *window;
	SCRemoteAccelerometer *remoteAccel;
	
	SCGraph *graph;
	
	IBOutlet SCPlotCanvas *plotCanvas; 
	IBOutlet NSDatePicker *wackupTimePicker;
	
	NSMutableArray *lastAccelerations;
	NSInteger count;
	
	BOOL isMonitoring;
	NSTimer *monitoringTimer;
	NSInteger activityCounter;
	NSSound *alarmSound;
}
@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) SCRemoteAccelerometer *remoteAccel;
@property (retain) NSTimer *monitoringTimer;

- (IBAction)timeChanged: (id)sender;

@end
