//
//  RegistViewController.h
//  StudyBook
//
//  Created by 石坂 達也 on 2013/06/21.
//  Copyright (c) 2013年 Tatsuya Ishisaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewController : UIViewController <UITextFieldDelegate>
{
    UIView* activeField;
    UIScrollView* scrollView;
}

- (IBAction)searchBotton:(id)sender;

- (IBAction)registBotton:(id)sender;
@property (retain, nonatomic) IBOutlet UIDatePicker *goalDate;

@property (retain, nonatomic) IBOutlet UILabel *tit;
@property (retain, nonatomic) IBOutlet UILabel *totalPage;
@property (retain, nonatomic) IBOutlet UILabel *isbn;

@end

