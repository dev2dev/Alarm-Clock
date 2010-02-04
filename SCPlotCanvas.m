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
- (NSRect)valueRangeRect;

@end

@implementation SCPlotCanvas
@synthesize width;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		graphs = [[NSMutableArray alloc] init];
		width = 1000;
	}

    return self;
}

- (void) dealloc
{
	[graphs release];
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	SC2DScale *scaler = [[[SC2DScale alloc] init] autorelease];
	[scaler setFromRect: [self valueRangeRect]];	
	[scaler setToRect: [self bounds]];
	
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

- (NSRect)valueRangeRect {
	if ([graphs count] == 0) {
		return NSMakeRect(0, -1, width, 2);
	}
	
	float currentMaxWidth = [(SCGraph *)[graphs objectAtIndex:0] width];
	
	float startingValue = currentMaxWidth - width;
	if (startingValue < 0) {
		startingValue = 0;
	}
	
	return NSMakeRect(startingValue, -1, width, 2);
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
