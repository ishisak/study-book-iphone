//
//  FlipsideViewController.h
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *startPage;
@property (retain, nonatomic) IBOutlet UITextField *endPage;
- (IBAction)registProgress:(id)sender;

@property (assign, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
