//
//  SC2DScale.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SC2DScale.h"
#import "SCScale.h"


@implementation SC2DScale

@synthesize fromRect, toRect;


- (id) init
{
	self = [super init];
	if (self != nil) {
		xScale = [[SCScale alloc] init];
		yScale = [[SCScale alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[xScale release];
	[yScale release];
	
	[super dealloc];
}

- (void)setFromRect:(NSRect) rect {
	fromRect = rect;
	
	[xScale setScaleFromRangeStarting:rect.origin.x ending:(rect.origin.x + rect.size.width)];
	[yScale setScaleFromRangeStarting:rect.origin.y ending:(rect.origin.y + rect.size.height)];
}

- (void)setToRect:(NSRect) rect {
	toRect = rect;
	
	[xScale setScaleToRangeStarting:rect.origin.x ending:(rect.origin.x + rect.size.width)];
	[yScale setScaleToRangeStarting:rect.origin.y ending:(rect.origin.y + rect.size.height)];
}
				  
- (NSPoint)scaleValue: (NSPoint) value {
	return NSMakePoint(
				[xScale scaleValue:value.x],
				[yScale scaleValue:value.y]
			);
}

@end
