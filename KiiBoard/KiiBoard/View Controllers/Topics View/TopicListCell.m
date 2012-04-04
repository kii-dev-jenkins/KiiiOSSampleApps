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
