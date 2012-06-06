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
}
@property (strong) IBOutlet NSPopover *formPopover;
@property (strong) IBOutlet NSMenu *detailMenu;
@property (weak) IBOutlet NSTextFieldCell *textField;
@property (weak) IBOutlet NSTextField *input;
@property (weak) IBOutlet NSTextField *output;

- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;
- (IBAction)speak:(id)sender;
- (IBAction)stopSpeak:(id)sender;
- (IBAction)countInput:(id)sender;
- (IBAction)showMenulet:(id)sender;


@end
