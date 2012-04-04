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

#import <UIKit/UIKit.h>

@interface CBLoader : UIView

#pragma mark - Public Static Methods

/* 
 The only method - static - and shows a toast with a given message at either
 a constant (found above) or at a user-defined time (in milliseconds)
 */
+ (void) showLoader:(NSString*)msg;

/*
 This can be called at any time. If any view is found that matches this
 class, it will be removed from its superview
 */
+ (void) hideLoader;

@end
