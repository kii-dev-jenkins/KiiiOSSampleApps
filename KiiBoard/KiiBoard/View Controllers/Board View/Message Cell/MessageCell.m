//
//  MessageCell.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/21/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize nameLabel, timeLabel, bodyLabel;

+ (CGFloat) getCellHeight:(NSString*)msg {
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 310, 20)];
    l.numberOfLines = 1000;
    l.lineBreakMode = UILineBreakModeWordWrap;
    l.font = [UIFont systemFontOfSize:13.0f];
    l.text = msg;
    
    
    //Calculate the expected size based on the font and linebreak mode of your label
    CGSize maximumLabelSize = CGSizeMake(l.frame.size.width, 9999);
    
    CGSize expectedLabelSize = [l.text sizeWithFont:l.font
                                  constrainedToSize:maximumLabelSize
                                      lineBreakMode:l.lineBreakMode]; 
    
    //adjust the label the the new height.
    CGRect newFrame = l.frame;
    newFrame.size.height = expectedLabelSize.height;
    l.frame = newFrame;
    
    return l.frame.size.height + l.frame.origin.y + 10.0f;
}

- (void) setMessageContent:(NSString*)content {
    
    bodyLabel.text = content;
    
    //Calculate the expected size based on the font and linebreak mode of your label
    CGSize maximumLabelSize = CGSizeMake(bodyLabel.frame.size.width, 9999);
    
    CGSize expectedLabelSize = [bodyLabel.text sizeWithFont:bodyLabel.font
                                          constrainedToSize:maximumLabelSize
                                              lineBreakMode:bodyLabel.lineBreakMode]; 
    
    //adjust the label the the new height.
    CGRect newFrame = bodyLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    bodyLabel.frame = newFrame;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 20)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        [self addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 20)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = UITextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:10.0f];
        [self addSubview:timeLabel];

        bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 310, 20)];
        bodyLabel.backgroundColor = [UIColor clearColor];
        bodyLabel.font = [UIFont systemFontOfSize:13.0f];
        bodyLabel.textColor = [UIColor blackColor];
        bodyLabel.numberOfLines = 1000;
        bodyLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self addSubview:bodyLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
