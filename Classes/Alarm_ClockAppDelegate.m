//
//  Alarm_ClockAppDelegate.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Alarm_ClockAppDelegate.h"
#import "SCGraph.h"

@interface Alarm_ClockAppDelegate (Private)

- (void)setupGraph;

@end




@implementation Alarm_ClockAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self setupGraph];
}

- (void)setupGraph {
	SCGraph *graph = [[SCGraph alloc] init];
	
	[graph addPoint: NSMakePoint(0, 0.1)];
	[graph addPoint: NSMakePoint(10, 0.5)];
	[graph addPoint: NSMakePoint(20, 0.1)];
	[graph addPoint: NSMakePoint(30, 0.2)];
	[graph addPoint: NSMakePoint(40, 0.1)];
	[graph addPoint: NSMakePoint(50, 0.2)];
	[graph addPoint: NSMakePoint(60, 0.1)];
	
	[plotCanvas addGraph: graph];
}


@end
