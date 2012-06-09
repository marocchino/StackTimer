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
- (void) cancle{
    self.status = [NSNumber numberWithInt:-1];
}
- (NSString *) titleWithInterval{
    NSTimeInterval elapsedTime = -[self.startedAt timeIntervalSinceNow];
    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",
                        lround(floor(elapsedTime / 3600)) % 100,
                        lround(floor(elapsedTime / 60)) % 60,
                        lround(floor(elapsedTime)) % 60];
    return [NSString stringWithFormat:@"%@  %@", self.title, string];
}

@end
