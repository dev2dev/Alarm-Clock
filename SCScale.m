//
//  SCScale.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SCScale.h"


@implementation SCScale

@synthesize fromRangeStart, fromRangeEnd;
@synthesize toRangeStart, toRangeEnd;

- (void)setScaleFromRangeStarting:(float)x1 ending:(float)x2 {
	self.fromRangeStart = x1;
	self.fromRangeEnd = x2;
}

- (void)setScaleToRangeStarting:(float)x1 ending:(float)x2 {
	self.toRangeStart = x1;
	self.toRangeEnd = x2;
}

- (float)scaleValue: (float)value {
	float fromLength = fromRangeEnd - fromRangeStart;
	float p = (value - fromRangeStart) / fromLength;
	
	float toLength = toRangeEnd - toRangeStart;
	return toRangeStart + (toLength * p);
}



@end
