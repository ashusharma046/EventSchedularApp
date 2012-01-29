//
//  FlipsideViewController.h
//  EventSchedularApp
//
//  Created by Aneesh on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Event.h"
@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
IBOutlet UITextField *nameField;
IBOutlet UITextView *description;
IBOutlet UITextField *dateField;    
    UIDatePicker *picker;  
    UIToolbar *bar;
}
@property (nonatomic,retain) IBOutlet id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextView *description;
@property (nonatomic,retain) IBOutlet UITextField *dateField;
@property (nonatomic, retain) NSDateFormatter *dateFormatter;
- (IBAction)done:(id)sender;
- (IBAction)back:(id)sender;
- (void)scheduleNotificationwithEvent : (Event *)event;

@end
