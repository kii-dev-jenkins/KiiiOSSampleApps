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

#import "CBLoader.h"

@implementation CBLoader

/* 
 The only method - static - and shows a toast with a given message at either
 a constant (found above) or at a user-defined time (in milliseconds)
 */
+ (void) showLoader:(NSString*)msg {
    
    // hide any pre-existing loaders
    [CBLoader hideLoader];
    
    // generate the new loader
    CBLoader *loader = [[CBLoader alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    loader.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.9f];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 30)];
    message.textAlignment = UITextAlignmentCenter;
    message.font = [UIFont boldSystemFontOfSize:14.0f];
    message.textColor = [UIColor whiteColor];
    message.text = msg;
    message.backgroundColor = [UIColor clearColor];
    [loader addSubview:message];
    [message release];
    
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.center = CGPointMake(160, 256);
    [loader addSubview:activity];
    [activity startAnimating];
    [activity release];
    
    // add the toast to the root window (so it overlays everything)
    [[[UIApplication sharedApplication] keyWindow] addSubview:loader];
    
    [loader release];
}

/*
 This can be called at any time. If any view is found that matches this
 class, it will be removed from its superview
 */
+ (void) hideLoader {
    
    for(UIView *v in [[[UIApplication sharedApplication] keyWindow] subviews]) {
        if([v isKindOfClass:[CBLoader class]]) {
            [v removeFromSuperview];
        }
    }
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
