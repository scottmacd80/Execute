//
//  EXEPlayViewController.m
//  Execute
//
//  Created by Scott MacDonald on 26/01/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

#import "EXEPlayViewController.h"

@implementation EXEPlayViewController

- (void)viewDidLoad {    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 100.0f, 280.0f, 44.0f)];
    textField.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySend;
    [self.view addSubview:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Message" message:textField.text delegate:nil cancelButtonTitle:@"Got it!" otherButtonTitles:nil];
    
    [alert show];
    [textField resignFirstResponder];
    textField.text = nil;
    
    return NO;
}

@end
