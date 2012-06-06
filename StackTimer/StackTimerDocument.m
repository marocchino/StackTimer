//
//  StackTimerDocument.m
//  StackTimer
//
//  Created by Taewon Shim on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StackTimerDocument.h"

@implementation StackTimerDocument
@synthesize formPopover;
@synthesize textField;
@synthesize input;
@synthesize output;
- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        _speechSynth = [[NSSpeechSynthesizer alloc]
                        initWithVoice:nil];
        [_speechSynth setDelegate:self];
    }
    return self;
}
- (void)awakeFromNib
{
    NSDate *now;
    now = [NSDate date];
    [textField setObjectValue:now];
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@"Status"];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    [statusItem setAction:@selector(showMenulet:)];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"StackTimerDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}
- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender
        didFinishSpeaking:(BOOL)finishedSpeaking
{
    NSLog(@"finishedSpeaking = %d", finishedSpeaking);
}

- (IBAction)seed:(id)sender {
    // Generate a number between 1 and 100 inclusive
    int generated;
    generated = (int)(random() % 100) + 1;
    NSLog(@"generated = %d", generated);
    // Ask the text field to change what it is displaying
    [textField setIntValue:generated];
}

- (IBAction)generate:(id)sender {
    // Seed the random number generator with the time
    srandom((unsigned)time(NULL));
    [textField setStringValue:@"Generator seeded"];
}

- (IBAction)speak:(id)sender {
    NSString *string = [input stringValue];
    // Is the string zero-length?
    if ([string length] == 0) {
        NSLog(@"string from %@ is of zero-length", textField);
        return; }
    [_speechSynth startSpeakingString:string];
    NSLog(@"Have started to say: %@", string);
}

- (IBAction)stopSpeak:(id)sender {
    [_speechSynth stopSpeaking];
}

- (IBAction)countInput:(id)sender {
    NSString *string = [input stringValue];
    if ([string length] == 0) {
        [output setStringValue:@"???"];
    } else {
        [output setStringValue:[NSString stringWithFormat:@"'%@'has %d char", string, [string length]]];
    }
}

- (IBAction)showMenulet:(id)sender {
    [formPopover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}
@end
