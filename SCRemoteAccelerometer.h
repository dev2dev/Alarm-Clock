//
//  SCRemoteAccelerometer.h
//  Alarm-Clock
//
//  Created by Christian Stropp on 03.02.10.
//  Copyright 2010 Christian Stropp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SCRemoteAccelerometer;


@protocol SCRemoteAccelrometerDelegate

@optional

- (void)remoteAccelerometer:(SCRemoteAccelerometer *)remoteAccelerometer didReceiveAcceleration:(float)acceleration;

@end



@interface SCRemoteAccelerometer : NSObject {
	id delegate;
	int serialport;
	Boolean isReading;
}
@property (nonatomic, assign) id <SCRemoteAccelrometerDelegate> delegate;

- (void)startReading;
- (void)stopReading;
- (void)readLoop;

- (Boolean)sendByte:(uint8_t)b;
- (Boolean)sendString:(NSString *)str;
- (NSString *)readUntilCharacter:(char)until;
- (Boolean)initSerialportWithName:(NSString *)serialportName andBaudRate:(int)baud;

@end
