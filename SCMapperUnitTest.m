//
//  SCMapperUnitTest.m
//  Alarm-Clock
//
//  Created by Robert Palmer on 30.01.10.
//  Copyright 2010 Robert. All rights reserved.
//

#import "SCMapperUnitTest.h"
#import "SCScale.h"


@implementation SCMapperUnitTest



- (void)testSCScaleCreation {
	SCScale *scale = [[SCScale alloc] init];
	STAssertNotNil(scale, @"scale should be created");
	
	[scale setScaleFromRangeStarting:0 ending: 10];
	STAssertEquals(0.0f, scale.fromRangeStart, @"range should start correct");
	STAssertEquals(10.0f, scale.fromRangeEnd, @"range should end correct");
	
	[scale setScaleToRangeStarting:50 ending: 100];
	STAssertEquals(50.0f, scale.toRangeStart, @"range should start correct");
	STAssertEquals(100.0f, scale.toRangeEnd, @"range should end correct");
	
	[scale release];
}

- (void)testScalingToSameRange {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:0 ending: 50];
	[scale setScaleToRangeStarting:0 ending: 50];
	
	STAssertEquals(0.0f, [scale scaleValue: 0], @"scale to right value");
	STAssertEquals(25.0f, [scale scaleValue: 25], @"scale to right value");
	STAssertEquals(50.0f, [scale scaleValue: 50], @"scale to right value");
	
	[scale release];
}

- (void)testScalingToMovedRange {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:0 ending: 50];
	[scale setScaleToRangeStarting:100 ending: 150];
	
	STAssertEquals(100.0f, [scale scaleValue: 0], @"scale to right value");
	STAssertEquals(125.0f, [scale scaleValue: 25], @"scale to right value");
	STAssertEquals(150.0f, [scale scaleValue: 50], @"scale to right value");
	
	[scale release];
}

- (void)testScalingToLargerRange {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:0 ending: 50];
	[scale setScaleToRangeStarting:0 ending: 100];
	
	STAssertEquals(0.0f, [scale scaleValue: 0], @"scale to right value");
	STAssertEquals(50.0f, [scale scaleValue: 25], @"scale to right value");
	STAssertEquals(100.0f, [scale scaleValue: 50], @"scale to right value");
	
	[scale release];
}

- (void)testScalingToSmallerRange {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:0 ending: 100];
	[scale setScaleToRangeStarting:0 ending: 10];
	
	STAssertEquals(0.0f, [scale scaleValue: 0], @"scale to right value");
	STAssertEquals(5.0f, [scale scaleValue: 50], @"scale to right value");
	STAssertEquals(10.0f, [scale scaleValue: 100], @"scale to right value");
	
	[scale release];
}

- (void)testScalingToFlippedRange {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:-10 ending: 10];
	[scale setScaleToRangeStarting:10 ending: -10];
	
	STAssertEquals(10.0f, [scale scaleValue: -10], @"scale to right value");
	STAssertEquals(0.0f, [scale scaleValue: 0], @"scale to right value");
	STAssertEquals(-10.0f, [scale scaleValue: 10], @"scale to right value");
	
	[scale release];
}

- (void)testScalingToMovedRange2 {
	SCScale *scale = [[SCScale alloc] init];
	[scale setScaleFromRangeStarting:-10 ending: 0];
	[scale setScaleToRangeStarting:0 ending: 10];
	
	STAssertEquals(0.0f, [scale scaleValue: -10], @"scale to right value");
	STAssertEquals(10.0f, [scale scaleValue: 0], @"scale to right value");
	
	[scale release];
}


@end
