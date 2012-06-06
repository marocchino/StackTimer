//
//  Work.h
//  StackTimer
//
//  Created by Taewon Shim on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Work;

@interface Work : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * startedAt;
@property (nonatomic, retain) NSDate * endedAt;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) Work *parent;

@end
