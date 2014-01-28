//
//  EXEListViewController.m
//  Execute
//
//  Created by Scott MacDonald on 28/01/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

#import "EXEListViewController.h"

@interface EXEListViewController ()

@property (nonatomic) NSMutableArray *tasks;

@end

@implementation EXEListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Execute";
    [self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"cell"];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 32.0f)];
    textfield.returnKeyType = UIReturnKeyGo;
    textfield.backgroundColor = [UIColor colorWithWhite:0.90f alpha:1.0f];
    textfield.placeholder = @"what do you want to execute?";
    self.navigationItem.titleView = textfield;
    
    self.tasks = [[NSMutableArray alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.tasks[indexPath.row];
    
    return cell;
}


@end
