//
//  StackTimerDocument.h
//  StackTimer
//
//  Created by Taewon Shim on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StackTimerDocument : NSPersistentDocument <NSApplicationDelegate, NSSpeechSynthesizerDelegate>
{
    NSSpeechSynthesizer *_speechSynth;
    NSStatusItem* statusItem;
    BOOL isMenuletVisible;
}
@property (strong) IBOutlet NSPopover *formPopover;
@property (weak) IBOutlet NSTextField *currentWorkField;
@property (weak) IBOutlet NSLayoutConstraint *currentWorkLabel;

- (IBAction)createTask:(id)sender;
- (void) initMenulet;
- (IBAction)speak:(id)sender;
- (IBAction)stopSpeak:(id)sender;
- (IBAction)showMenulet:(id)sender;

@end
