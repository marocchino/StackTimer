//
//  Task.m
//  StackTimer
//
//  Created by Taewon Shim on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Task.h"
#import "Task.h"


@implementation Task

@dynamic depth;
@dynamic endedAt;
@dynamic startedAt;
@dynamic status;
@dynamic title;
@dynamic parent;
@dynamic children;

- (void) start{
    self.status = [NSNumber numberWithInt:1];
}

- (void) pending{
    self.status = [NSNumber numberWithInt:2];
}

- (void) finish{
    self.status = [NSNumber numberWithInt:0];
}

- (void) cancel{
    self.status = [NSNumber numberWithInt:-1];
}

- (BOOL) isTimeToSay:(int) min{
    NSTimeInterval elapsedTime = -[self.startedAt timeIntervalSinceNow];
    if ((lround(floor(elapsedTime / 60)) % 60 % min == 0) && (lround(floor(elapsedTime)) % 60 == 0)){
        return YES;
    }
    return NO;
}

- (NSString *) interval {
    NSTimeInterval elapsedTime = -[self.startedAt timeIntervalSinceNow];
    return [NSString stringWithFormat:@"%02li:%02li:%02li",
                        lround(floor(elapsedTime / 3600)) % 100,
                        lround(floor(elapsedTime / 60)) % 60,
                        lround(floor(elapsedTime)) % 60];
}

- (NSString *) titleWithInterval{
    return [NSString stringWithFormat:@"%@  %@", self.title, self.interval];
}

@end
