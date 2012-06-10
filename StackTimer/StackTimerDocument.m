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
@synthesize titleInputField;
@synthesize currentTitleLabel;
@synthesize spendTimeLabel;

- (id)init
{
    self = [super init];
    if (self) {
        // init SpeechSynthesizer
        _speechSynth = [[NSSpeechSynthesizer alloc]
                        initWithVoice:nil];
        [_speechSynth setDelegate:self];
        // init Timer
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self     selector:@selector(advanceTimer:) userInfo:nil repeats:YES];
        runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:countdownTimer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void) initMenulet {
    isMenuletVisible = NO;
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@"StackTimer"];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    [statusItem setAction:@selector(toggleMenulet:)];
}

- (void)initCurrentTask
{
    NSError *error = nil;
    NSFetchRequest* fetchRequest = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"status == %d", 1];
    NSMutableArray *tasks = [[[self managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSLog(@"%@", tasks);
    if ([tasks lastObject]) {
        NSLog(@"success");
        [self setCurrentTask:[tasks lastObject]];
    } else {
        [self setCurrentTask:nil];
    }
}

- (void)awakeFromNib
{
    [self initMenulet];
    [self initCurrentTask];
    
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

- (IBAction)createTask:(id)sender {
    NSString *title = [titleInputField stringValue];
    NSError *error;
    Task *task = (Task*) [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:[self managedObjectContext]];
    
    task.title = title;
    task.startedAt = [NSDate date];
    if (currentTask) {
        task.parent = currentTask;
        [currentTask pending];
    }
    [task start];
    
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    } else {
        [self setCurrentTask:task];
        [titleInputField setStringValue:@""];
        [self toggleMenulet:nil];
    }
}

- (void)advanceTimer:(NSTimer *)timer
{
    if (currentTask) {
        [self displayTitle];
        [self speakElapsedTime];
    }
}

- (void)setCurrentTask:(Task *)task{
    currentTask = task;
    [self displayTitle];
}

- (void) displayTitle{
    if (currentTask) {
        [currentTitleLabel setStringValue:currentTask.title];
        [statusItem setTitle:currentTask.titleWithInterval];
        [spendTimeLabel setStringValue:currentTask.interval];
    } else {
        [statusItem setTitle:@"StackTimer"];
    }
}

- (void)speakElapsedTime {
    int min = 30;
    if (currentTask && [currentTask isTimeToSay: min]) {
        [_speechSynth startSpeakingString:[NSString stringWithFormat: @"another %d minutes have passed", min]];
    }
}

- (void)toggleMenulet:(id)sender {
    isMenuletVisible = !isMenuletVisible;
    if (isMenuletVisible) {
        [formPopover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
    } else {
        [formPopover close];
    };
}

- (void)closeTask:(NSString *)status {
    NSError *error;
    Task *task = currentTask;
    if ([status isEqualToString:@"complete"]) {
        [task finish];
    } else {
        [task cancel];
    }
    task.endedAt = [NSDate date];
    if ([task parent]) {
        [self setCurrentTask:[task parent]];
        [currentTask start];
    } else {
        [self setCurrentTask:nil];
    }
    if (![[self managedObjectContext] save:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    } else {
        [self toggleMenulet:nil];
    }
}

- (IBAction)completeTask:(id)sender {
    [self closeTask:@"complete"];
}

- (IBAction)cancelTask:(id)sender {
    [self closeTask:@"cancel"];
}
@end
