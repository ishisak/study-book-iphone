//
//  RegistViewController.m
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bookName.delegate = self;
        self.totalPages.delegate = self;
        self.goalDate.delegate = self;
        self.barcode.delegate = self;
    [self registerForKeyboardNotifications];
	// Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bookName release];
    [_totalPages release];
    [_goalDate release];
    [_barcode release];
    [super dealloc];
}

- (IBAction)registBotton:(id)sender {
//    [self.view endEditing: YES];
    NSLog(@"%@", self.bookName.text);
        NSLog(@"%@", self.totalPages.text);
        NSLog(@"%@", self.goalDate.text);
        NSLog(@"%@", self.barcode.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"kkk");
  //  if (textField == self.bookName) {
        [textField resignFirstResponder];
  //  }
    return YES;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    NSLog(@"notification");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"wasShown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
        NSLog(@"beHidden");
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"end %@", textField.text);

    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
        NSLog(@"start %@", textField.text);
    activeField = nil;
}

@end
