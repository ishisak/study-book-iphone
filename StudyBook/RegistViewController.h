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

- (IBAction)registBotton:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *bookName;
@property (retain, nonatomic) IBOutlet UITextField *totalPages;
@property (retain, nonatomic) IBOutlet UITextField *goalDate;
@property (retain, nonatomic) IBOutlet UITextField *barcode;

@end

