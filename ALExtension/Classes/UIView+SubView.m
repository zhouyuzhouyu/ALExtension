//
//  UIView+SubView.m
//  pandora
//
//  Created by zhongbin on 2017/6/16.
//  Copyright © 2017年 Albert Lee. All rights reserved.
//

#import "UIView+SubView.h"

@implementation UIView (SubView)

- (UIView *)subViewOfClassName:(NSString *)className{

  for (UIView* subView in self.subviews) {
    if ([NSStringFromClass(subView.class) isEqualToString:className]) {
      return subView;
    }
    UIView* resultFound = [subView subViewOfClassName:className];
    if (resultFound) {
      return resultFound;
    }
  }
  return nil;
  
}

- (UIView *)subViewOfViewTag:(NSInteger )viewTag{
    
    UIView * tagView = [self viewWithTag:viewTag];
    if (tagView) {
        return tagView;
    }else{
        for (UIView* subView in self.subviews) {
            if ([subView viewWithTag:viewTag]) {
                return [subView viewWithTag:viewTag];
            }
        }
        return nil;
    }
}

- (void)removeSubViewOfViewTag:(NSInteger )viewTag{
    
    UIView * tagView = [self viewWithTag:viewTag];
    if (tagView) {
        [tagView removeFromSuperview];
    }else{
        for (UIView* subView in self.subviews) {
            if ([subView viewWithTag:viewTag]) {
                 [tagView removeFromSuperview];
            }
        }
    }
}

- (BOOL)isTopView:(UIView *)view{
    NSArray * aryView = self.subviews;
    UIView *topView = [aryView lastObject];
    if (aryView && aryView.count > 1) {
        if ([topView isEqual:view]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

- (BOOL)isSubView:(UIView *)view{
     NSArray * aryViews = self.subviews;
    for (UIView *subview in aryViews) {
        if ([subview isEqual:view]) {
            return YES;
        }
    }
    return NO;
}

@end
