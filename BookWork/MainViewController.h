//
//  MainViewController.h
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UILabel *bookTitle;
@property (retain, nonatomic) IBOutlet UILabel *remainPages;
@property (retain, nonatomic) IBOutlet UILabel *remainDays;
//@property (retain, nonatomic) IBOutlet UILabel *currentPstr;


@end
