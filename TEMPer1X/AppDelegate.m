//
//  AppDelegate.m
//  TEMPer1X
//
//  Created by Andrew Mannering on 26/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SSLTEMPer1Controller.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize guage = _guage;
@synthesize text = _text;
@synthesize readButton = _readButton;

SSLTEMPer1Controller *temper1;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    temper1 = [[SSLTEMPer1Controller alloc] init];
}

- (IBAction)readTemp:(id)sender
{
    float temp = [temper1 getTemp];
    [_guage setFloatValue:temp];
    [_text setFloatValue:temp];
}

@end
