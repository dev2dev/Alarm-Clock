//
//  SCPlotCanvas.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert All rights reserved.
//

#import "SCPlotCanvas.h"


@implementation SCPlotCanvas

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetRGBFillColor (myContext, 0, 0, 0, 1);
    CGContextFillRect (myContext, dirtyRect);
}

@end
