//
//  SCGraph.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 31.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SC2DScale;


@interface SCGraph : NSObject {
	NSMutableArray *points;
	
	SC2DScale *scaler;
}

@property (retain) SC2DScale *scaler;

- (void)addPoint: (NSPoint)point;
- (void)draw: (CGContextRef) context;


@end
