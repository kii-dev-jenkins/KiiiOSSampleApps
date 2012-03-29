//
//  MessageCell.h
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/21/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (nonatomic, retain) NSNumber *messageOnLeft;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *bodyLabel;

+ (CGFloat) getCellHeight:(NSString*)msg withTime:(NSString*)time isLeft:(BOOL)isLeft;
- (void) setMessageContent:(NSString*)content withTime:(NSString*)time;

@end
