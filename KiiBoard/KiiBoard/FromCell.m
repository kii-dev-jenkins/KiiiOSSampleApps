/*************************************************************************
 
 Copyright 2012 Kii Corporation
 http://kii.com
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 *************************************************************************/

#import "FromCell.h"

@implementation FromCell

@synthesize title;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 320, 20)];
        title.textAlignment = UITextAlignmentCenter;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont boldSystemFontOfSize:12.0f];
        title.textColor = [UIColor colorWithWhite:0.517647059 alpha:1.0f];
        title.shadowColor = [UIColor whiteColor];
        title.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:title];
        
    }
    
    return self;
}

@end
