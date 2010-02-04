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

@synthesize window;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification; {
	[self setupGraph];
	
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(addPoint) userInfo:nil repeats:YES]; 
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
	[graph addPoint: NSMakePoint(0, 0.1)];
	[graph addPoint: NSMakePoint(10, 0.5)];
	count = 1;
	
	[plotCanvas addGraph: graph];
	plotCanvas.width = 1000;
}

- (void)addPoint {
	count += 1;
	
	float random = (rand() % 200) - 100;
	[graph addPoint: NSMakePoint(count * 10, random / 200.0f)];
}





@end
