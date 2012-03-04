//
//  SSLTEMPer1Controller.h
//  TEMPer1X
//
//  Created by Andrew Mannering on 27/02/2012.
//  Copyright (c) 2012 Sledgehammer Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VENDOR_ID 0x0c45
#define PRODUCT_ID 0x7401
#define HID_USAGE_PAGE 0xff00
#define HID_USAGE 0x01

@interface SSLTEMPer1Controller : NSObject 

- (int)getDeviceCount;
- (float)getTemp;

@end
