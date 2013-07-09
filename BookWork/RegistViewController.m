//
//  RegistViewController.m
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()
@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation RegistViewController
@synthesize responseData = _responseData;
@synthesize tit = _tit;
@synthesize totalPage = _totalPage;
@synthesize isbn = _isbn;

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
    [_isbn setHidden:TRUE];
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    
    // Do any additional setup after loading the view.
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
   // NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSArray *books = [res objectForKey:@"books"];
    NSDictionary *relevantObject = [books objectAtIndex:0];
    NSString *btitle = [relevantObject objectForKey:@"title"];
    NSNumber *ppages = [relevantObject objectForKey:@"pages"];
    NSString *bookKey = [relevantObject objectForKey:@"bookKey"];
    NSString *pageStr = [ppages stringValue];

    self.tit.text = btitle;
    self.totalPage.text = pageStr;
    self.isbn.text = bookKey;
    
    
    
   // self.totalPages.text = pages;
    

}


- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_goalDate release];
    [_tit release];
    [_totalPage release];
    [_isbn release];
    [super dealloc];
}

- (IBAction)searchBotton:(id)sender {
    
    //http connection
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://study-book-rest.herokuapp.com/isbn/9780521189064"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)registBotton:(id)sender {
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    dateString = [formatter stringFromDate:self.goalDate.date];
    
    [formatter release];
    
    NSLog(@"%@", self.isbn.text);
    NSLog(@"%@", dateString);
    
    NSString *url = [NSString stringWithFormat:@"http://study-book-rest.herokuapp.com/user/regist/099999/%@/%@",self.isbn.text,dateString] ;
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:url]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
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
