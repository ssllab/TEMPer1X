//
//  AppDelegate.h
//  TEMPer1X
//
//  Created by Andrew Mannering on 26/02/2012.
//  Copyright (c) 2012 Sledgehammer Solutions Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> 

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSLevelIndicator *guage;
@property (assign) IBOutlet NSTextField *text;
@property (assign) IBOutlet NSButton *readButton;

- (IBAction)readTemp:(id)sender;

@end
