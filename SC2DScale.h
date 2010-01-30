//
//  SC2DScale.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SCScale;

@interface SC2DScale : NSObject {
	NSRect fromRect;
	NSRect toRect;
	
	SCScale *xScale;
	SCScale *yScale;
}

@property (assign) NSRect fromRect;
@property (assign) NSRect toRect;

- (NSPoint)scaleValue: (NSPoint) value;

@end
