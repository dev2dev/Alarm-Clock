//
//  SC2DScaleUnitTest.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SC2DScaleUnitTest.h"
#import "SC2DScale.h"


@implementation SC2DScaleUnitTest

- (void)test2DScaleCreation {
	SC2DScale *scale = [[SC2DScale alloc] init];
	STAssertNotNil(scale, @"scale should be cerated");
	
	scale.fromRect = NSMakeRect(0, 0, 100, 100);
	STAssertTrue(NSEqualRects(scale.fromRect, NSMakeRect(0, 0, 100, 100)), @"rects should be equal"); 
	
	scale.toRect = NSMakeRect(0, 100, 100, 100);
	STAssertTrue(NSEqualRects(scale.toRect, NSMakeRect(0, 100, 100, 100)), @"rects should be equal"); 
	
	[scale release];
}

- (void)testScaleXAxis {
	SC2DScale *scale = [[SC2DScale alloc] init];
	scale.fromRect = NSMakeRect(0, 0, 10, 100);
	scale.toRect = NSMakeRect(0, 0, 100, 100);
	
	NSPoint value = NSMakePoint(0, 0);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(0, 0)), @"should be equal");
	
	value = NSMakePoint(5, 5);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(50, 5)), @"should be equal");
	
	value = NSMakePoint(10, 100);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(100, 100)), @"should be equal");
}


- (void)testScaleYAxis {
	SC2DScale *scale = [[SC2DScale alloc] init];
	scale.fromRect = NSMakeRect(0, 0, 100, 10);
	scale.toRect = NSMakeRect(0, 0, 100, 100);
	
	NSPoint value = NSMakePoint(0, 0);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(0, 0)), @"should be equal");

	value = NSMakePoint(0, 5);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(0, 50)), @"should be equal");

	value = NSMakePoint(0, 10);
	STAssertTrue(NSEqualPoints([scale scaleValue: value], NSMakePoint(0, 100)), @"should be equal");
}



@end
