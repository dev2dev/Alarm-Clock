//
//  SCGraph.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 31.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SCGraph.h"
#import "SC2DScale.h"


@implementation SCGraph

- (id) init
{
	self = [super init];
	if (self != nil) {
		points = [[NSMutableArray alloc] initWithObjects:
				  [NSValue valueWithPoint: NSMakePoint(0, 0.1)],
				  [NSValue valueWithPoint: NSMakePoint(10, 0.5)],
				  [NSValue valueWithPoint: NSMakePoint(20, 0.1)],
				  [NSValue valueWithPoint: NSMakePoint(30, 0.2)],
				  [NSValue valueWithPoint: NSMakePoint(40, 0.1)],
				  [NSValue valueWithPoint: NSMakePoint(50, 0.2)],
				  [NSValue valueWithPoint: NSMakePoint(40, 0.1)],

				  nil];
		
		scaler = [[SC2DScale alloc] init];
		[scaler setFromRect:NSMakeRect(0, -3, 100, 6)];
		[scaler setToRect:NSMakeRect(0, 0, 400, 400)];
	}
	return self;
}

- (void) dealloc
{
	[scaler release];
	[points release];
	
	[super dealloc];
}

- (void)draw: (CGContextRef) context {
	CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);

	CGContextBeginPath(context);
	NSPoint point = [[points objectAtIndex:0] pointValue];
	point = [scaler scaleValue:point];
	CGContextMoveToPoint(context, point.x, point.y);

	for (int i = 1; i < [points count]; i++) {
		point = [[points objectAtIndex:i] pointValue];
		point = [scaler scaleValue:point];

		CGContextAddLineToPoint(context, point.x, point.y);
	}
	
	CGContextStrokePath(context);
}

@end
