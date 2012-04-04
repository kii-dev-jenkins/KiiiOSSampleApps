//
//
//  Copyright 2012 Kii Corporation
//  http://kii.com
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize timeLabel, bodyLabel, messageOnLeft;

+ (CGFloat) getCellHeight:(NSString*)msg withTime:(NSString*)time isLeft:(BOOL)isLeft {

    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1000)];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 300, 20)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor colorWithWhite:0.517647059 alpha:1.0f];
    timeLabel.font = [UIFont systemFontOfSize:12.0f];
    [container addSubview:timeLabel];
    
    UILabel *bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 250, 20)];
    bodyLabel.backgroundColor = [UIColor redColor];
    bodyLabel.font = [UIFont systemFontOfSize:13.0f];
    bodyLabel.textColor = [UIColor blackColor];
    bodyLabel.numberOfLines = 1000;
    bodyLabel.lineBreakMode = UILineBreakModeWordWrap;
    [container addSubview:bodyLabel];

    timeLabel.text = time;
    bodyLabel.text = msg;
    
    // set the time label
    CGRect newFrame = timeLabel.frame;
    
    //Calculate the expected size based on the font and linebreak mode of your label
    CGSize maximumLabelSize = CGSizeMake(300, 20);
    CGSize expectedLabelSize = [timeLabel.text sizeWithFont:timeLabel.font
                                          constrainedToSize:maximumLabelSize
                                              lineBreakMode:UILineBreakModeTailTruncation];
    
    NSLog(@"Time label (%lfx%lf)", expectedLabelSize.width, expectedLabelSize.height);
    
    newFrame.size.width = expectedLabelSize.width;
    newFrame.origin.x = isLeft ? 310 - expectedLabelSize.width : 10;
    timeLabel.frame = newFrame;
    
    // get the bubble width
    CGPoint bubbleOrigin = bodyLabel.frame.origin;
    CGFloat bubbleWidth = 300.0f - timeLabel.frame.size.width - 12.0f;
    
    //Calculate the expected size based on the font and linebreak mode of your label
    maximumLabelSize = CGSizeMake(bubbleWidth - 28.0f, 9999);
    expectedLabelSize = [bodyLabel.text sizeWithFont:bodyLabel.font
                                   constrainedToSize:maximumLabelSize
                                       lineBreakMode:bodyLabel.lineBreakMode]; 
    
    newFrame.origin.x = timeLabel.frame.origin.x;
    newFrame.size.width = 310;
    newFrame.size.height = expectedLabelSize.height + 28.0f;
    timeLabel.frame = newFrame;
    
    // draw the bubble in this frame (min 22x29)
    CGPoint origin = CGPointMake(isLeft ? 10 : 310 - bubbleWidth, bubbleOrigin.y);
    UIImageView *_1_1 = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x, origin.y, 9, 14)];
    [_1_1 setImage:[UIImage imageNamed:@"rb-1-1"]];
    [container addSubview:_1_1];
    
    UIImageView *_1_3 = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x + bubbleWidth - 12, origin.y, 12, 14)];
    [_1_3 setImage:[UIImage imageNamed:@"rb-1-3"]];
    [container addSubview:_1_3];
    
    UIImageView *_3_1 = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x, origin.y + expectedLabelSize.height + 28.0f - _1_3.frame.size.height, _1_1.frame.size.width, _1_3.frame.size.height)];
    [_3_1 setImage:[UIImage imageNamed:@"rb-3-1"]];
    [container addSubview:_3_1];
    
    UIView *_1_2 = [[UIView alloc] initWithFrame:CGRectMake(origin.x+_1_1.frame.size.width, origin.y, bubbleWidth - _1_1.frame.size.width - _1_3.frame.size.width, 14)];
    [_1_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rb-1-2"]]];
    [container addSubview:_1_2];
    
    UIView *_2_1 = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y + _1_1.frame.size.height, _1_1.frame.size.width, expectedLabelSize.height + 28.0f - _1_1.frame.size.height - _3_1.frame.size.height)];
    [_2_1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rb-2-1"]]];
    [container addSubview:_2_1];
    
    UIView *_2_2 = [[UIView alloc] initWithFrame:CGRectMake(_1_2.frame.origin.x, _2_1.frame.origin.y, _1_2.frame.size.width, _2_1.frame.size.height)];
    [_2_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rb-2-2"]]];
    [container addSubview:_2_2];
    
    UIView *_2_3 = [[UIView alloc] initWithFrame:CGRectMake(_1_3.frame.origin.x, _2_1.frame.origin.y, _1_3.frame.size.width, _2_1.frame.size.height)];
    [_2_3 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rb-2-3"]]];
    [container addSubview:_2_3];
    
    UIView *_3_2 = [[UIView alloc] initWithFrame:CGRectMake(_1_2.frame.origin.x, _3_1.frame.origin.y, _1_2.frame.size.width, _3_1.frame.size.height)];
    [_3_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"rb-3-2"]]];
    [container addSubview:_3_2];
    
    UIImageView *_3_3 = [[UIImageView alloc] initWithFrame:CGRectMake(_1_3.frame.origin.x, _3_1.frame.origin.y, _1_3.frame.size.width, _3_1.frame.size.height)];
    [_3_3 setImage:[UIImage imageNamed:@"rb-3-3"]];
    [container addSubview:_3_3];
    
    newFrame = bodyLabel.frame;
    newFrame.origin.x = _1_1.frame.origin.x + _1_1.frame.size.width;
    newFrame.origin.y = _1_1.frame.origin.y + _1_1.frame.size.height;
    newFrame.size.height = _2_1.frame.size.height;
    newFrame.size.width = _2_2.frame.size.width;
    bodyLabel.frame = newFrame;
        
    CGFloat totalHeight = _3_3.frame.origin.y + _3_3.frame.size.height;
    
    [_1_1 release];
    [_1_2 release];
    [_1_3 release];
    [_2_1 release];
    [_2_2 release];
    [_2_3 release];
    [_3_1 release];
    [_3_2 release];
    [_3_3 release];
    
    [container release];


    return totalHeight;
}

- (void) setMessageContent:(NSString*)content withTime:(NSString*)time {
    
    timeLabel.text = time;
    bodyLabel.text = content;
    
    // set the time label
    CGRect newFrame = timeLabel.frame;
    
    //Calculate the expected size based on the font and linebreak mode of your label
    CGSize maximumLabelSize = CGSizeMake(300, 20);
    CGSize expectedLabelSize = [timeLabel.text sizeWithFont:timeLabel.font
                                          constrainedToSize:maximumLabelSize
                                              lineBreakMode:UILineBreakModeTailTruncation];
    
    NSLog(@"Time label (%lfx%lf)", expectedLabelSize.width, expectedLabelSize.height);
    
    newFrame.size.width = expectedLabelSize.width;
    newFrame.origin.x = [messageOnLeft boolValue] ? 310 - expectedLabelSize.width : 10;
    timeLabel.frame = newFrame;
    
    // get the bubble width
    CGPoint bubbleOrigin = bodyLabel.frame.origin;
    CGFloat bubbleWidth = 300.0f - timeLabel.frame.size.width - 12.0f;

    //Calculate the expected size based on the font and linebreak mode of your label
    maximumLabelSize = CGSizeMake(bubbleWidth - 28.0f, 9999);
    expectedLabelSize = [bodyLabel.text sizeWithFont:bodyLabel.font
                                          constrainedToSize:maximumLabelSize
                                              lineBreakMode:bodyLabel.lineBreakMode]; 
        
    newFrame.origin.x = timeLabel.frame.origin.x;
    newFrame.size.width = 310;
    newFrame.size.height = expectedLabelSize.height + 28.0f;
    timeLabel.frame = newFrame;
    
    // draw the bubble in this frame (min 22x29)
    CGPoint origin = CGPointMake([messageOnLeft boolValue] ? 10 : 310 - bubbleWidth, bubbleOrigin.y);
    
    NSString *imgPrefix = [messageOnLeft boolValue] ? @"lb" : @"rb";
    
    CGRect _1_1_f = [messageOnLeft boolValue] ? CGRectMake(origin.x, origin.y, 12, 14) : CGRectMake(origin.x, origin.y, 9, 14);
    UIImageView *_1_1 = [[UIImageView alloc] initWithFrame:_1_1_f];
    [_1_1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-1-1", imgPrefix]]];
    [self addSubview:_1_1];

    CGRect _1_3_f = [messageOnLeft boolValue] ? CGRectMake(origin.x + bubbleWidth - 9, origin.y, 9, 14) : CGRectMake(origin.x + bubbleWidth - 12, origin.y, 12, 14);
    UIImageView *_1_3 = [[UIImageView alloc] initWithFrame:_1_3_f];
    [_1_3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-1-3", imgPrefix]]];
    [self addSubview:_1_3];
    
    UIImageView *_3_1 = [[UIImageView alloc] initWithFrame:CGRectMake(origin.x, origin.y + expectedLabelSize.height + 28.0f - _1_3.frame.size.height, _1_1.frame.size.width, _1_3.frame.size.height)];
    [_3_1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-3-1", imgPrefix]]];
    [self addSubview:_3_1];

    CGRect _1_2_f = CGRectMake(origin.x+_1_1.frame.size.width, origin.y, bubbleWidth - _1_1.frame.size.width - _1_3.frame.size.width, _1_1.frame.size.height);
    UIView *_1_2 = [[UIView alloc] initWithFrame:_1_2_f];
    [_1_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-1-2", imgPrefix]]]];
    [self addSubview:_1_2];
    
    UIView *_2_1 = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y + _1_1.frame.size.height, _1_1.frame.size.width, expectedLabelSize.height + 28.0f - _1_1.frame.size.height - _3_1.frame.size.height)];
    [_2_1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-2-1", imgPrefix]]]];
    [self addSubview:_2_1];
    
    UIView *_2_2 = [[UIView alloc] initWithFrame:CGRectMake(_1_2.frame.origin.x, _2_1.frame.origin.y, _1_2.frame.size.width, _2_1.frame.size.height)];
    [_2_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-2-2", imgPrefix]]]];
    [self addSubview:_2_2];
    
    UIView *_2_3 = [[UIView alloc] initWithFrame:CGRectMake(_1_3.frame.origin.x, _2_1.frame.origin.y, _1_3.frame.size.width, _2_1.frame.size.height)];
    [_2_3 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-2-3", imgPrefix]]]];
    [self addSubview:_2_3];
    
    UIView *_3_2 = [[UIView alloc] initWithFrame:CGRectMake(_1_2.frame.origin.x, _3_1.frame.origin.y, _1_2.frame.size.width, _3_1.frame.size.height)];
    [_3_2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-3-2", imgPrefix]]]];
    [self addSubview:_3_2];
    
    UIImageView *_3_3 = [[UIImageView alloc] initWithFrame:CGRectMake(_1_3.frame.origin.x, _3_1.frame.origin.y, _1_3.frame.size.width, _3_1.frame.size.height)];
    [_3_3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-3-3", imgPrefix]]];
    [self addSubview:_3_3];

    newFrame = bodyLabel.frame;
    newFrame.origin.x = _1_1.frame.origin.x + _1_1.frame.size.width;
    newFrame.origin.y = _1_1.frame.origin.y + _1_1.frame.size.height;
    newFrame.size.height = _2_1.frame.size.height;
    newFrame.size.width = _2_2.frame.size.width;
    bodyLabel.frame = newFrame;

    [self bringSubviewToFront:bodyLabel];
    
    [_1_1 release];
    [_1_2 release];
    [_1_3 release];
    [_2_1 release];
    [_2_2 release];
    [_2_3 release];
    [_3_1 release];
    [_3_2 release];
    [_3_3 release];

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 300, 20)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithWhite:0.517647059 alpha:1.0f];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:timeLabel];

        bodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 250, 20)];
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
