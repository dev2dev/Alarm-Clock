//
//  SCPlotCanvas.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SCGraph;


@interface SCPlotCanvas : NSView {
	NSMutableArray *graphs;
	
	float width;
}
@property (assign) float width;

- (void)addGraph: (SCGraph *)graph;

@end
