//
//  NSString+Paid.m
//  AntLive
//
//  Created by yu zhou on 4/3/24.
//

#import <Foundation/Foundation.h>

@implementation UIWindow (ALExtension)
+ (void)removeWindowSubview{
  for (UIView *view in [UIApplication sharedApplication].delegate.window.subviews) {
    if (view.tag == (1<<15)) {
      [view removeFromSuperview];
    }
  }
}
+ (void)addWindowSubview:(UIView *)view{
  view.tag = (1<<15);
  [[UIApplication sharedApplication].delegate.window addSubview:view];
}

+ (BOOL)isViewOnMainWindow:(UIView *)view{
  for (UIView *subview in [UIApplication sharedApplication].delegate.window.subviews) {
    if ([subview isEqual:view]) {
      return YES;
    }
  }
  return NO;
}

+ (UIView *)isViewOfClassOnMainView:(__unsafe_unretained Class)className{
  for (UIView *subview in [UIApplication sharedApplication].delegate.window.subviews) {
    if ([subview isKindOfClass:className]) {
      return subview;
    }
  }
  return nil;
}


+(BOOL)windowsWithTopView:(__unsafe_unretained Class)className{
    NSArray * curVCAry =   [UIApplication sharedApplication].delegate.window.subviews;
    id obj = [curVCAry lastObject];
    if ([obj isKindOfClass:className]) {
        return YES;
    }else{
        return NO;
    }
}



+ (void )windowsRemoveWithTopView:(__unsafe_unretained Class)className{
    for (UIView *subview in [UIApplication sharedApplication].delegate.window.subviews) {
        if ([subview isKindOfClass:className]) {
            [subview removeFromSuperview];
        }
    }
}



@end





