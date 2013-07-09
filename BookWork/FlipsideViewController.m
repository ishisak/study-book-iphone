//
//  FlipsideViewController.m
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()
@property (nonatomic, strong) NSMutableData *responseData;
@property(nonatomic) UIKeyboardType keyboardType;
@end

@implementation FlipsideViewController
@synthesize stPage = _stPage;
@synthesize endPage = _endPage;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    self.stPage.text = [self.delegate getStPage:self];
    NSLog(@"%@",self.stPage.text);

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    NSLog(@"kkkkk");
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)dealloc {
    [_stPage release];
    [super dealloc];
}
- (IBAction)registProgress:(id)sender {

    if(self.endPage.text != (id)[NSNull null] && self.endPage.text.length > 0) {
        //http connection
       
        self.responseData = [NSMutableData data];
        NSString *url = [NSString stringWithFormat:@"http://study-book-rest.herokuapp.com/user/progess/099999/%@",self.endPage.text] ;
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:url]];
        
        
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        NSLog(@"dd %@",self.endPage.text);
        
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Notice" message:@"Please input Page"
                                  delegate:self cancelButtonTitle:@"dismiss" otherButtonTitles:nil];
        [alert show];
        
    }





 }
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    // NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Progress was updated"
                              delegate:self cancelButtonTitle:@"Retry" otherButtonTitles:@"End", nil];
    [alert show];
    [alert release];

    
    // self.totalPages.text = pages;
    
    
}


-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            break;
        case 1:
                [self.delegate flipsideViewControllerDidFinish:self];
            //２番目のボタンが押されたときの処理を記述する
            break;
    }
    
}

@end
