//
//  MainViewController.m
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "MainViewController.h"
//#import "Venue.h"

@interface MainViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSString *strPstr;

@end

@implementation MainViewController
@synthesize responseData = _responseData;
@synthesize bookTitle = _bookTitle;
@synthesize remainDays = _remainDays;
@synthesize remainPages = _remainPages;
//@synthesize currentPstr =_currentPstr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://study-book-rest.herokuapp.com/user/get/099999"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];

	// Do any additional setup after loading the view, typically from a nib.
    
    // facebook login check
   // AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
   // [appDelegate openSessionWithAllowLoginUI:NO];
    
    //connect rest server
    //http://api.openweathermap.org/data/2.5/weather?q=London,uk
    
    // Set object attributes
    
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
    
    NSDictionary *books = [res objectForKey:@"bookInfo"];
    NSString *btitle = [books objectForKey:@"title"];
    
    NSDictionary *setting = [res objectForKey:@"setting"];
    NSNumber *remainP = [setting objectForKey:@"remainPages"];
    NSString *pageStr = [remainP stringValue];
    
    NSNumber *remainD = [setting objectForKey:@"remainDays"];
    NSString *dayStr = [remainD stringValue];
    
    self.strPstr = [setting objectForKey:@"currentPage"];
  //  NSString *hoge  = currentP;
    
  
    self.bookTitle.text = btitle;
    self.remainPages.text = pageStr;
    self.remainDays.text = dayStr;

    // self.totalPages.text = pages;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)getStPage:(FlipsideViewController *)controller
{
     return self.strPstr;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)authButtonAction:(id)sender {
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the person is authenticated, log out when the button is clicked.
    // If the person is not authenticated, log in when the button is clicked.
    /*
     if (FBSession.activeSession.isOpen) {
     [appDelegate closeSession];
     } else {
     // The person has initiated a login, so call the openSession method
     // and show the login UX if necessary.
     [appDelegate openSessionWithAllowLoginUI:YES];
     }
     */
}

- (void)sessionStateChanged:(NSNotification*)notification {
    /*
     if (FBSession.activeSession.isOpen) {
     [self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
     } else {
     [self.authButton setTitle:@"Login" forState:UIControlStateNormal];
     }
     */
}
- (void)dealloc {
    [_bookTitle release];
    [_remainPages release];
    [_remainDays release];
 //   [_currentPstr release];
    [super dealloc];
}


@end
