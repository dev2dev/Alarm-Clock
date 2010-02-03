//
//  SCPlotCanvas.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert All rights reserved.
//

#import "SCPlotCanvas.h"
#import "SCGraph.h"
#import "SC2DScale.h"


@implementation SCPlotCanvas

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        graph = [[SCGraph alloc] init];
		
		[graph addPoint: NSMakePoint(0, 0.1)];
		[graph addPoint: NSMakePoint(10, 0.5)];
		[graph addPoint: NSMakePoint(20, 0.1)];
		[graph addPoint: NSMakePoint(30, 0.2)];
		[graph addPoint: NSMakePoint(40, 0.1)];
		[graph addPoint: NSMakePoint(50, 0.2)];
		[graph addPoint: NSMakePoint(60, 0.1)];
	}

    return self;
}

- (void) dealloc
{
	[graph release];

	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	NSRect rect = NSMakeRect(0, 0, [self frame].size.width, [self frame].size.height);

	SC2DScale *scaler = [[[SC2DScale alloc] init] autorelease];
	[scaler setFromRect:NSMakeRect(0, -1, 60, 2)];
	[scaler setToRect: rect];
	
	graph.scaler = scaler;
	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetRGBFillColor(myContext, 0, 0, 0, 1);
    CGContextFillRect(myContext, dirtyRect);
	
	[graph draw: myContext];
}

@end
