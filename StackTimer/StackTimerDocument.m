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
        [formPopover close];
    }
}

- (void)advanceTimer:(NSTimer *)timer
{
    if (currentTask) {
        [self displayTitle];
    }
}

- (void)setCurrentTask:(Task *)task{
    currentTask = task;
    [self displayTitle];
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self     selector:@selector(advanceTimer:) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:countdownTimer forMode:NSDefaultRunLoopMode];
}
- (void) displayTitle{
    if (currentTask) {
        [currentTitleLabel setStringValue:currentTask.titleWithInterval];
        [statusItem setTitle:currentTask.titleWithInterval];
    } else {
        [statusItem setTitle:@"StackTimer"];
    }
}
- (void) initMenulet {
    isMenuletVisible = NO;
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@"StackTimer"];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    [statusItem setAction:@selector(showMenulet:)];
}

- (IBAction)speak:(id)sender {
    NSString *string = [titleInputField stringValue];
    // Is the string zero-length?
    if ([string length] == 0) {
        NSLog(@"string from %@ is of zero-length", titleInputField);
        return; }
    [_speechSynth startSpeakingString:string];
}

- (IBAction)stopSpeak:(id)sender {
    [_speechSynth stopSpeaking];
}


- (IBAction)showMenulet:(id)sender {
    isMenuletVisible = !isMenuletVisible;
    if (isMenuletVisible) {
        [formPopover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
    } else {
        [formPopover close];
    };
}

- (IBAction)completeTask:(id)sender {
    NSError *error;
    Task *task = currentTask;
    [task finish];
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
        [formPopover close];
    }
}

- (IBAction)cancleTask:(id)sender {
    NSError *error;
    Task *task = currentTask;
    [task cancle];
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
        [formPopover close];
    }
}
@end
