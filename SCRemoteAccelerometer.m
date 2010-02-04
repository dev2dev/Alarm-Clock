//
//  SCRemoteAccelerometer.m
//  Alarm-Clock
//
//  Created by Christian Stropp on 03.02.10.
//  Copyright 2010 Christian Stropp. All rights reserved.
//

#import "SCRemoteAccelerometer.h"

#import <stdio.h>    /* Standard input/output definitions */
#import <stdlib.h> 
#import <stdint.h>   /* Standard types */
#import <string.h>   /* String function definitions */
#import <unistd.h>   /* UNIX standard function definitions */
#import <fcntl.h>    /* File control definitions */
#import <errno.h>    /* Error number definitions */
#import <termios.h>  /* POSIX terminal control definitions */
#import <sys/ioctl.h>
#import <getopt.h>

#define kSerialportName		@"/dev/tty.usbserial-A600ahGl"
#define kBaudRate			9600

@implementation SCRemoteAccelerometer

@synthesize delegate;

- (id)init
{
	if (self = [super init])
	{
		if (![self initSerialportWithName:kSerialportName andBaudRate:kBaudRate])
			return nil;
		
		isReading = NO;
	}
	return self;
}


- (void)startReading
{
	isReading = YES;
	
	[NSThread detachNewThreadSelector:@selector(readLoop) toTarget:self withObject:nil];
}


- (void)stopReading
{
	isReading = NO;
}


- (void)readLoop
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	while (isReading)
	{
		NSString *message = [self readUntilCharacter:'\n'];
		//NSLog(@"%@", message);
		if ([delegate respondsToSelector:@selector(remoteAccelerometer:didReceiveAcceleration:)]) 
			[delegate remoteAccelerometer:self didReceiveAcceleration:[message floatValue]];
	}
	
	[pool drain];
}


- (Boolean)sendByte:(uint8_t)b
{
    int n = write(serialport, &b, 1);
    if (n != 1)
        return NO;
	
    return YES;
}


#pragma mark -
#pragma mark Serial Communication
// based on: http://todbot.com/blog/2006/12/06/arduino-serial-c-code-to-talk-to-arduino/

- (Boolean)sendString:(NSString *)str
{
    int len = strlen([str UTF8String]);
    int n = write(serialport, [str UTF8String], len);
    if (n != len) 
        return NO;
	
    return YES;
}

- (NSString *)readUntilCharacter:(char)until
{
	char buf[128];
    char b[1];
    int i = 0;
    do
	{ 
        int n = read(serialport, b, 1);  // read a char at a time
        
		if (n == -1)
			return nil;    // couldn't read
		
        if (n == 0)
		{
            usleep(10 * 1000); // wait 10 msec try again
            continue;
        }
		
        buf[i] = b[0];
		i++;
    } while (b[0] != until);
	
    buf[i] = 0;  // null terminate the string
    return [NSString stringWithUTF8String:buf];
}
												   

// takes the string name of the serial port (e.g. "/dev/tty.usbserial","COM1")
// and a baud rate (bps) and connects to that port at that speed and 8N1.
// opens the port in fully raw mode so you can send binary data.
// returns valid fd, or -1 on error
- (Boolean)initSerialportWithName:(NSString *)serialportName andBaudRate:(int)baud
{
    struct termios toptions;
    
    //fprintf(stderr,"init_serialport: opening port %s @ %d bps\n",
    //        serialport,baud);
	
    serialport = open([serialportName UTF8String], O_RDWR | O_NOCTTY | O_NDELAY);
    if (serialport == -1)  {
        perror("init_serialport: Unable to open port ");
        return NO;
    }
    
    if (tcgetattr(serialport, &toptions) < 0) {
        perror("init_serialport: Couldn't get term attributes");
        return NO;
    }
    speed_t brate = baud; // let you override switch below if needed
    switch(baud) {
		case 4800:   brate=B4800;   break;
		case 9600:   brate=B9600;   break;
#ifdef B14400
		case 14400:  brate=B14400;  break;
#endif
		case 19200:  brate=B19200;  break;
#ifdef B28800
		case 28800:  brate=B28800;  break;
#endif
		case 38400:  brate=B38400;  break;
		case 57600:  brate=B57600;  break;
		case 115200: brate=B115200; break;
    }
    cfsetispeed(&toptions, brate);
    cfsetospeed(&toptions, brate);
	
    // 8N1
    toptions.c_cflag &= ~PARENB;
    toptions.c_cflag &= ~CSTOPB;
    toptions.c_cflag &= ~CSIZE;
    toptions.c_cflag |= CS8;
    // no flow control
    toptions.c_cflag &= ~CRTSCTS;
	
    toptions.c_cflag |= CREAD | CLOCAL;  // turn on READ & ignore ctrl lines
    toptions.c_iflag &= ~(IXON | IXOFF | IXANY); // turn off s/w flow ctrl
	
    toptions.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG); // make raw
    toptions.c_oflag &= ~OPOST; // make raw
	
    // see: http://unixwiz.net/techtips/termios-vmin-vtime.html
    toptions.c_cc[VMIN]  = 0;
    toptions.c_cc[VTIME] = 20;
    
    if (tcsetattr(serialport, TCSANOW, &toptions) < 0) {
        perror("init_serialport: Couldn't set term attributes");
        return NO;
    }
	
    return YES;
}

@end
