//
//  EXETaskTableViewCell.h
//  Execute
//
//  Created by Scott MacDonald on 03/02/2014.
//  Copyright (c) 2014 Scott MacDonald. All rights reserved.
//

@interface EXETaskTableViewCell : UITableViewCell

@property (nonatomic) NSString *task;
@property (nonatomic) BOOL completed;
@property (nonatomic, readonly) UITapGestureRecognizer *editGestureRecognizer;

@end
