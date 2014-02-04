//
//  EXEEditViewController.m
//  Execute
//
//  Created by Scott MacDonald on 03/02/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

#import "EXEEditViewController.h"
#import "EXETaskTextField.h"

@interface EXEEditViewController ()
@property (nonatomic) EXETaskTextField *textField;
@property (nonatomic) CGRect keyboardFrame;

@end

@implementation EXEEditViewController

@synthesize  textField = _textField;

- (EXETaskTextField *)textField {
    if (_textField == nil) {
        _textField = [[EXETaskTextField alloc] init];
    }
    return _textField;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     
     [self.textField becomeFirstResponder];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize size = self.view.bounds.size;
    
    self.textField.frame = CGRectMake(10.0f, roundf((size.height - self.keyboardFrame.size.height + self.topLayoutGuide.length - 44.0f) / 2.0f), size.width - 20.0f, 44.0f);
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [value CGRectValue];
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self viewDidLayoutSubviews];
    }];
}

@end
