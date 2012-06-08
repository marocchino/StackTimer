//
//  Task.h
//  StackTimer
//
//  Created by Taewon Shim on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * startedAt;
@property (nonatomic, retain) NSDate * endedAt;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * depth;
@property (nonatomic, retain) Task *parent;
@property (nonatomic, retain) NSSet *children;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addChildrenObject:(Task *)value;
- (void)removeChildrenObject:(Task *)value;
- (void)addChildren:(NSSet *)values;
- (void)removeChildren:(NSSet *)values;

@end
