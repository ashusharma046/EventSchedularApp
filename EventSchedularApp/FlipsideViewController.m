//
//  FlipsideViewController.m
//  EventSchedularApp
//
//  Created by Aneesh on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "AppDelegate.h"
#import "Event.h"

@implementation FlipsideViewController

@synthesize delegate = _delegate;
@synthesize description;
@synthesize nameField,dateField;
@synthesize dateFormatter;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark -
#pragma mark textField delegate methods

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"ashu sharma");
    if(textField==dateField){
        [textField resignFirstResponder];
        picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,95,100,100)];
        bar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,70,320,25)];
        UIButton* setTimeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        setTimeButton.titleLabel.text=@"Set Time";
        UIBarButtonItem *barButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(do)];
        bar.items=[NSArray arrayWithObjects: barButton, nil];
        [self.view addSubview:picker];
        [self.view addSubview:bar];
        return NO;
        
    }
	return YES;
}
-(void)do{
    dateField.text=[self.dateFormatter stringFromDate:[picker date]];
    [picker setDatePickerMode:UIDataDetectorTypeCalendarEvent];
    [picker removeFromSuperview];
    [bar removeFromSuperview];
    
}


- (void)scheduleNotificationwithEvent :(Event *)event{
	
    
    
    Class cls = NSClassFromString(@"UILocalNotification");
    if (cls != nil) {
		
        UILocalNotification *notif = [[cls alloc] init];
    
        notif.fireDate =[[self dateFormatter] dateFromString:dateField.text];
        notif.timeZone = [NSTimeZone defaultTimeZone];
		
        notif.alertBody = event.desc;
        notif.alertAction = event.name;
        notif.soundName = UILocalNotificationDefaultSoundName;
        notif.applicationIconBadgeNumber = 1;
		
      
		
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        
    }
}



- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  	
    [textField resignFirstResponder];
	return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    	
    [textView resignFirstResponder];
	return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (NSDateFormatter *)dateFormatter {	
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
	}
	return dateFormatter;
}
#pragma mark - Actions
- (IBAction)back:(id)sender{
 
     [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender
{
    if([nameField.text length]>0 && [description.text length]>0){
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Event" 
                                                            inManagedObjectContext:context];
    [object setValue:nameField.text forKey:@"name"];
    [object setValue:description.text forKey:@"desc"];
    
    [object setValue:[self.dateFormatter dateFromString:dateField.text] forKey:@"date"];
     NSError *error;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
    [self scheduleNotificationwithEvent:(Event *)object];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Event schedulded"
                                                          message:@"Your event has been scheduled successfully."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];    
    [self dismissModalViewControllerAnimated:YES];
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Fill carefully"
                                                          message:@"Please fill all fields carefully."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];    }
    
}   
@end
