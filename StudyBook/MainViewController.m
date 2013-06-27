//
//  MainViewController.m
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "MainViewController.h"
#import "Venue.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
      [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // facebook login check
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate openSessionWithAllowLoginUI:NO];
    
    //connect rest server
    //http://api.openweathermap.org/data/2.5/weather?q=London,uk
   
    // Set object attributes
    
    // Interpolate with the object

    NSURL *baseURL = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/"]http://api.openweathermap.org/data/2.5/"];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[[NSURL URLWithString:@"weather?q=London,uk" relativeToURL:baseURL]];
    [NSURL URLWithString:@"weather?bar=baz" relativeToURL:baseURL];

                                
    [manager.router.routeSet addRoute:[RKRoute routeWithClass:[RKArticle class] pathPattern:@"/weather/:comment.name/articles/:articleID/comments/" method:RKRequestMethodGET]];

    [manager getObject:article path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSLog(@"Loading mapping result: %@", result);
    } failure:nil];
                                
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)authButtonAction:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // If the person is authenticated, log out when the button is clicked.
    // If the person is not authenticated, log in when the button is clicked.
    if (FBSession.activeSession.isOpen) {
        [appDelegate closeSession];
    } else {
        // The person has initiated a login, so call the openSession method
        // and show the login UX if necessary.
        [appDelegate openSessionWithAllowLoginUI:YES];
    }
    
}

- (void)sessionStateChanged:(NSNotification*)notification {
    if (FBSession.activeSession.isOpen) {
        [self.authButton setTitle:@"Logout" forState:UIControlStateNormal];
    } else {
        [self.authButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}
- (void)dealloc {
    [_authButton release];
    [_userNameLabel release];
    [super dealloc];
}

@end
