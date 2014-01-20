//
//  ToDoItemCell.m
//  ToDoApp4
//
//  Created by Mike North on 1/19/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import "ToDoItemCell.h"

@implementation ToDoItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.listenedTo = false;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"todoTitleChanged" object:self];


    return NO;
}


@end
