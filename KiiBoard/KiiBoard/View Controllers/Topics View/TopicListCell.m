//
//  TopicListCell.m
//  KiiBoard
//
//  Created by Chris Beauchamp on 3/29/12.
//  Copyright (c) 2012 Chris Beauchamp. All rights reserved.
//

#import "TopicListCell.h"

@implementation TopicListCell

@synthesize title, time;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 280, 20)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:15.0f];
        title.textColor = [UIColor blackColor];
        title.shadowColor = [UIColor whiteColor];
        title.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:title];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(10, 34, 280, 15)];
        time.backgroundColor = [UIColor clearColor];
        time.font = [UIFont systemFontOfSize:12.0f];
        time.textColor = [UIColor colorWithWhite:0.517647059f alpha:1.0f];
        time.shadowColor = [UIColor whiteColor];
        time.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:time];        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
