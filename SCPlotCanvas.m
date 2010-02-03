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

@interface SCPlotCanvas (Private)

- (void)graphChanged;

@end



@implementation SCPlotCanvas

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		graphs = [[NSMutableArray alloc] init];
	}

    return self;
}

- (void) dealloc
{
	[graphs release];

	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	NSRect rect = NSMakeRect(0, 0, [self frame].size.width, [self frame].size.height);

	SC2DScale *scaler = [[[SC2DScale alloc] init] autorelease];
	[scaler setFromRect:NSMakeRect(0, -1, 1000, 2)];
	[scaler setToRect: rect];
	
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetRGBFillColor(myContext, 0, 0, 0, 1);
    CGContextFillRect(myContext, dirtyRect);
	
	for (SCGraph *graph in graphs) {
		graph.scaler = scaler;
		[graph draw: myContext];
	}
}

- (void)addGraph: (SCGraph *)graph {
	[graph addObserver:self forKeyPath:@"dirty" options:(NSKeyValueObservingOptionNew)
			   context:nil];

	graph.dirty = NO;

	
	[graphs addObject:graph];	
	[self graphChanged];
}


#pragma mark -
#pragma mark Private Methods

- (void)graphChanged {
	[self setNeedsDisplay:YES];

}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context	{
	
	if ([[change valueForKey:@"new"] boolValue] == YES) {
		[self graphChanged];
	}
}


@end
