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


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self setupGraph];
	
	[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addPoint) userInfo:nil repeats:YES]; 
	
	remoteAccel = [[SCRemoteAccelerometer alloc] init];
	remoteAccel.delegate = self;
	[remoteAccel startReading];
}

- (void) dealloc
{
	[graph release];
	[plotCanvas release];
	
	[super dealloc];
}


#pragma mark -
#pragma mark Private Methods
- (void)setupGraph {
	graph = [[SCGraph alloc] init];
	[plotCanvas addGraph: graph];
}


#pragma mark -
#pragma mark Remote Accelerometer Delegate Methods

- (void)remoteAccelerometer:(SCRemoteAccelerometer *)remoteAccelerometer didReceiveAcceleration:(float)acceleration
{
	count += 1;
	
	[graph addPoint: NSMakePoint(count * 10, acceleration)];
}


@end
