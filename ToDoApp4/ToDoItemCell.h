//
//  ToDoItemCell.h
//  ToDoApp4
//
//  Created by Mike North on 1/19/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoItemCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (atomic) BOOL listenedTo;

@end
