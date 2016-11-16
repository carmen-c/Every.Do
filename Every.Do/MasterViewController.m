//
//  MasterViewController.m
//  Every.Do
//
//  Created by carmen cheng on 2016-11-15.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "AddItemViewController.h"
#import "Todo.h"
#import "TodoCell.h"

@interface MasterViewController ()
@property NSMutableArray *listOfTodos;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.listOfTodos = [[NSMutableArray alloc]init];
    Todo *todo = [[Todo alloc]init];
    todo.title = @"cook";
    todo.todoDescription = @"cook dinner tonight";
    todo.priorityNumber = 1;
    todo.isCompleted = NO;
    
    Todo *todo1 = [[Todo alloc]init];
    todo1.title = @"dishes";
    todo1.todoDescription = @"wash dishes";
    todo1.priorityNumber = 2;
    todo1.isCompleted = NO;
    [self.listOfTodos addObject:todo1];
    [self.listOfTodos addObject:todo];
    
    //NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputted:) name:@"textInputed" object:nil];
    
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    
    [self performSegueWithIdentifier:@"createNew" sender:self];
    
    if (!self.listOfTodos) {
        self.listOfTodos = [[NSMutableArray alloc] init];
    }
//    [self.listOfTodos insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Todo *object = self.listOfTodos[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
    else if ([[segue identifier] isEqualToString:@"createNew"]) {
        AddItemViewController *at = (AddItemViewController *)[segue destinationViewController];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTodos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];

    Todo *object = self.listOfTodos[indexPath.row];
    cell.cellTitle.text = object.title;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.listOfTodos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark - Notification

-(void)textInputted:(NSNotification *)notification{
    Todo *additem = [notification.userInfo objectForKey:@"textInput"];
    
    [self.listOfTodos insertObject:additem atIndex:0];
    [self.tableView reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
