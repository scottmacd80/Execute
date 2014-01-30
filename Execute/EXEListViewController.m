//
//  EXEListViewController.m
//  Execute
//
//  Created by Scott MacDonald on 28/01/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

#import "EXEListViewController.h"

@interface EXEListViewController () <UITextFieldDelegate>

@property (nonatomic) NSMutableArray *tasks;

@property (nonatomic) NSMutableArray *completedTasks;

@end

@implementation EXEListViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Execute";
    [self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"cell"];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 32.0f)];
    textfield.returnKeyType = UIReturnKeyGo;
    textfield.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
    textfield.placeholder = @"what do you want to do?";
    textfield.delegate = self;
    self.navigationItem.titleView = textfield;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"✏️" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit:)];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadedTasks = [userDefaults arrayForKey:@"tasks"];
    self.tasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
    
    loadedTasks = [userDefaults arrayForKey:@"completedTasks"];
    self.completedTasks = [[NSMutableArray alloc] initWithArray:loadedTasks];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (editing) {
        self.navigationItem.rightBarButtonItem.title = @"👍";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"✏️";
    }
}

#pragma mark - Actions

- (void)toggleEdit:(id)sender {
    [self setEditing:!self.editing animated:YES];
}

#pragma mark - Private

- (void)save {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.tasks forKey:@"tasks"];
    [userDefaults setObject:self.completedTasks forKey:@"completedTasks"];
    [userDefaults synchronize];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [self.completedTasks count];
    }
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.tasks[indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        cell.textLabel.text = self.completedTasks[indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView beginUpdates];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    // Tapped an uncompleted task. Time to complete it!
    if (indexPath.section == 0){
    
        NSString *task = self.tasks[indexPath.row];
        
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.completedTasks insertObject:task atIndex:0];
        
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    // Tapped a completed task. Time to uncomplete it!
    else {
        
        NSString *task = self.completedTasks[indexPath.row];
        
        [self.completedTasks removeObjectAtIndex:indexPath.row];
        [self.tasks insertObject:task atIndex:0];
        
        [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    [tableView endUpdates];
    
    [self save];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tasks insertObject:textField.text atIndex:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
    textField.text = nil;
    
    [self save];
    
    return NO;
}


@end
