//
//  SCGraph.h
//  Alarm-Clock
//
//  Created by Robert Palmer on 31.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SCGraph : NSObject {
	NSMutableArray *points;

}

- (void)draw: (CGContextRef) context;


@end
