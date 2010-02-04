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

#define kSleepActivityTreshold		12
#define kActivityRecognitionCount	36000

@interface Alarm_ClockAppDelegate (Private)

- (void)setupGraph;

@end




@implementation Alarm_ClockAppDelegate

@synthesize window, remoteAccel;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification; {
	[self setupGraph];
	
	remoteAccel = [[SCRemoteAccelerometer alloc] init];
	remoteAccel.delegate = self;
	[remoteAccel startReading];
	
	lastAccelerations = [[NSMutableArray alloc] init];
	activityCounter = 0;
	
	alarmSound = [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dance" ofType:@"aif"] byReference:YES];
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
	plotCanvas.width = 1000;
}


#pragma mark -
#pragma mark Remote Accelerometer Delegate Methods

- (void)remoteAccelerometer:(SCRemoteAccelerometer *)remoteAccelerometer didReceiveAcceleration:(float)acceleration
{
	if (lastAccelerations.count >= 20)
		[lastAccelerations removeObjectAtIndex:0];
	
	[lastAccelerations addObject:[NSNumber numberWithFloat:acceleration]];
	
	float avg = [[lastAccelerations valueForKeyPath:@"@avg.floatValue"] floatValue];
	
	if (avg > kSleepActivityTreshold)
	{
		activityCounter += 1;
	}
	
	if (activityCounter > kActivityRecognitionCount)
	{
		alarmSound.loops = YES;
		[alarmSound play];
	}
	
	count += 1;
	[graph addPoint: NSMakePoint(count, avg)];
}


@end
