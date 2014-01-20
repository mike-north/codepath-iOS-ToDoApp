//
//  ToDoItem.h
//  ToDoApp4
//
//  Created by Mike North on 1/19/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, strong) NSString *title;

//Dictionary Constructor
- (id) init;
- (id) initWithDictionary:(NSDictionary *)dictionary;
@end
