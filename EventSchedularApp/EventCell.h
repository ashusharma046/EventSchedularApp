//
//  EventCell.h
//  EventSchedular
//
//  Created by Aneesh on 17/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UITextView *descLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;


@end
