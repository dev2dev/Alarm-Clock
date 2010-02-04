//
//  Alarm_ClockAppDelegate.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Alarm_ClockAppDelegate.h"
#import "SCGraph.h"
#import "SCPlotCanvas.h"

@interface Alarm_ClockAppDelegate (Private)

- (void)setupGraph;

@end




@implementation Alarm_ClockAppDelegate

@synthesize window, remoteAccel;
@synthesize monitoringTimer;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification; {
	[self setupGraph];
	
	remoteAccel = [[SCRemoteAccelerometer alloc] init];
	remoteAccel.delegate = self;
	[remoteAccel startReading];
	
	wackupTimePicker.dateValue = [NSDate date];
}

- (void) dealloc
{
	[graph release];
	[plotCanvas release];
	[wackupTimePicker release];
	
	[super dealloc];
}

- (IBAction)timeChanged: (id)sender {
	[self.monitoringTimer invalidate];
	
	NSDate *wakeupTime = [wackupTimePicker dateValue];
	if ([wakeupTime compare:[NSDate date]] == NSOrderedAscending) {
		wakeupTime = [wakeupTime dateByAddingTimeInterval: 24*60*60];
	}  	

	NSTimeInterval secondsToSleep = [wakeupTime timeIntervalSinceNow] - 30*60;
	
	self.monitoringTimer = [NSTimer scheduledTimerWithTimeInterval:secondsToSleep target:self selector:@selector(startSleepMonitoring) userInfo:nil repeats:NO];
	
	NSLog(@"time changed %@", wakeupTime);
}




#pragma mark -
#pragma mark Private Methods
- (void)setupGraph {

	graph = [[SCGraph alloc] init];

	[plotCanvas addGraph: graph];
	plotCanvas.width = 1000;
}


#pragma mark -
#pragma mark Remote Accelerometer Delegate Methods

- (void)remoteAccelerometer:(SCRemoteAccelerometer *)remoteAccelerometer didReceiveAcceleration:(float)acceleration
{
	count += 1;
	
	[graph addPoint: NSMakePoint(count, acceleration)];
}

- (void)startSleepMonitoring 
{
	
}


@end
