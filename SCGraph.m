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

@synthesize scaler;
@synthesize dirty;

- (id) init {
	self = [super init];
	if (self != nil) {
		points = [[NSMutableArray alloc] init]; 
		dirty = NO;
	}
	
	return self;
}

- (void) dealloc {
	[scaler release];
	[points release];
	
	[super dealloc];
}

- (void)addPoint: (NSPoint)point {
	[points addObject:[NSValue valueWithPoint: point]];
	self.dirty = YES;
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

	self.dirty = NO;
}


@end
