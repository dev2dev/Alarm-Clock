//
//  SCGraph.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 31.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SCGraph.h"


@implementation SCGraph

- (id) init
{
	self = [super init];
	if (self != nil) {
		points = [[NSMutableArray alloc] initWithObjects:NSMakePoint(<#CGFloat x#>, <#CGFloat y#>)
	}
	return self;
}



- (void)draw: (CGContextRef) context {
	CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);

	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0, 0);
	CGContextAddLineToPoint(context, 50, 50);
	CGContextAddLineToPoint(context, 100, 0);
	CGContextStrokePath(context);
}

@end
