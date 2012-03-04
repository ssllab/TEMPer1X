//
//  AppDelegate.m
//  TEMPer1X
//
//  Created by Andrew Mannering on 26/02/2012.
//  Copyright (c) 2012 Sledgehammer Solutions Ltd. All rights reserved.
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

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}

- (IBAction)readTemp:(id)sender
{
    if ([temper1 getDeviceCount] == 0) 
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle: @"OK"];
        [alert setMessageText: @"Unable to find a TEMPer1 device connected to this Mac."];
        [alert setInformativeText: @"No device matching the profile of the TEMPer1 could be found. " 
         @"Check that your device is a TEMPer1 and that your USB connections are good and try again."];
        [alert setAlertStyle: NSInformationalAlertStyle];
        [alert beginSheetModalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    else if ([temper1 getDeviceCount] == 0) 
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle: @"OK"];
        [alert setMessageText: @"Found more than one TEMPer1 device connected to this Mac."];
        [alert setInformativeText: @"Currently TEMPer1X can only display the value of a single connected TEMPer1 device. "
         @"Disconnect any extra TEMPer1 devices and try again."];
        [alert setAlertStyle: NSInformationalAlertStyle];
        [alert beginSheetModalForWindow:_window modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    else 
    {
        float temp = [temper1 getTemp];
        [_guage setFloatValue:temp];
        [_text setFloatValue:temp];
    }
}

@end
