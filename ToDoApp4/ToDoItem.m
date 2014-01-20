//
//  ToDoItem.m
//  ToDoApp4
//
//  Created by Mike North on 1/19/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import "ToDoItem.h"

@interface ToDoItem ()

@end


@implementation ToDoItem

- (id)init
{
    self = [super init];
    self.title = @"";
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = [dictionary objectForKey:@"title"];
    }
    return self;
}

@end
