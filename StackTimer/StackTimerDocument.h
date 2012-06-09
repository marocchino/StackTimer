//
//  StackTimerDocument.h
//  StackTimer
//
//  Created by Taewon Shim on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Task.h"

@interface StackTimerDocument : NSPersistentDocument <NSApplicationDelegate, NSSpeechSynthesizerDelegate>
{
    NSSpeechSynthesizer *_speechSynth;
    NSStatusItem *statusItem;
    BOOL isMenuletVisible;
    Task *currentTask;
    NSTimer *countdownTimer;
    NSRunLoop *runLoop;
}
@property (strong) IBOutlet NSPopover *formPopover;
@property (weak) IBOutlet NSTextField *titleInputField;
@property (weak) IBOutlet NSTextField *currentTitleLabel;

- (IBAction)createTask:(id)sender;
- (IBAction)completeTask:(id)sender;
- (IBAction)cancelTask:(id)sender;

@end
