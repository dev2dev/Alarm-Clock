//
//  SCScale.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SCScale : NSObject {
	float fromRangeStart, fromRangeEnd;
	float toRangeStart, toRangeEnd;
}

@property (assign) float fromRangeStart, fromRangeEnd;
@property (assign) float toRangeStart, toRangeEnd;


- (void)setScaleFromRangeStarting:(float)x1 ending:(float)x2;
- (void)setScaleToRangeStarting:(float)x1 ending:(float)x2;
- (float)scaleValue: (float)value;

@end
