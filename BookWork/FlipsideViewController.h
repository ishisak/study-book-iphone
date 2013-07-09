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
- (NSString*)getStPage:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (assign, nonatomic) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *endPage;

@property (retain, nonatomic) IBOutlet UILabel *stPage;
- (IBAction)registProgress:(id)sender;


@end
