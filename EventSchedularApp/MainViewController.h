//
//  MainViewController.h
//  EventSchedularApp
//
//  Created by Aneesh on 18/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
