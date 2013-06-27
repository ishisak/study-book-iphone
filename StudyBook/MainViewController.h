//
//  MainViewController.h
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "FlipsideViewController.h"
#import "AppDelegate.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate >
- (IBAction)authButtonAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *authButton;
@property (retain, nonatomic) IBOutlet UILabel *userNameLabel;

@end
