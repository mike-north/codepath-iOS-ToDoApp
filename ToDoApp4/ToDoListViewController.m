//
//  ToDoListViewController.m
//  ToDoApp4
//
//  Created by Mike North on 1/19/14.
//  Copyright (c) 2014 Mike North. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoItemCell.h"
#import "objc/runtime.h"

static char indexPathKey = 'a';

@interface ToDoListViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButtonItem;
@property (strong, nonatomic) NSMutableArray *todoItems;

@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"To Do List";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Global event for when todo item labels change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:@"todoTitleChanged" object:nil ];


    UINib *todoTableCellNib = [UINib nibWithNibName:@"ToDoItemCell" bundle:nil];
    [self.tableView registerNib:todoTableCellNib forCellReuseIdentifier:@"ToDoItemCell"];
    
    
    [self loadData];
    
    // Enable the "edit" menu item
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // Create an "add" menu item
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                               initWithTitle:@"+ Add"
                                               style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(addTodoItem:)] animated:YES];
}

- (void) loadData
{
    
    // get user preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get the default tip (by segment index). I checked to make sure
    // that if the user hasn't set a default, we get 0 (a reasonable value)
    NSArray *restoredToDoItems = [defaults arrayForKey:@"todoItems"];
    if (restoredToDoItems == nil) {
        self.todoItems = [[NSMutableArray alloc] init];
    }
    else {
        self.todoItems = [[NSMutableArray alloc] initWithArray:restoredToDoItems];
    }

    NSLog(@"Loaded %d", self.todoItems.count);
}

- (void) saveData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.todoItems forKey:@"todoItems"];
    [defaults synchronize]; // FLUSH!
}


- (void) textFieldChanged: (NSNotification *) notification
{
    ToDoItemCell *cell = (ToDoItemCell*)notification.object;
    
//    NSIndexPath *indexPath = objc_getAssociatedObject(cell.titleField, &indexPathKey);
    int row = [[self.tableView indexPathForCell:cell] row];
    self.todoItems[row] = cell.titleField.text;
    [self saveData];
}

// Handler for the "Add" menu item
- (void) addTodoItem:(id)sender
{
    // Add the item to our array of strings
    [self.todoItems addObject:@""];
    
    
    // Create an array of index paths (only one in our case, always at the 0th index))
    NSArray *tempArray = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    
    // Tell the tableView to add a new row!
    [[self tableView] beginUpdates];
    [[self tableView] insertRowsAtIndexPaths:(NSArray *)tempArray withRowAnimation:UITableViewRowAnimationNone];
    [[self tableView] endUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.todoItems.count;
}

- (void) methodToHandel: (id)sender
{
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ToDoItemCell";
    ToDoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"Cell - %d", [indexPath row]);
    cell.titleField.text = self.todoItems[[indexPath row]];
    [cell.titleField setPlaceholder: @"New To-do Item"];
    // Configure the cell...
    
    objc_setAssociatedObject(cell.titleField, &indexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [cell.titleField addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionOld context:nil];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSLog(@"DELETE %d", [indexPath row]);
        [self.todoItems removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self saveData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
