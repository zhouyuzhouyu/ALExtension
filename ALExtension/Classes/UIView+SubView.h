//
//  UIView+SubView.h
//  pandora
//
//  Created by zhongbin on 2017/6/16.
//  Copyright © 2017年 Albert Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SubView)

- (UIView*)subViewOfClassName:(NSString*)className;
- (UIView *)subViewOfViewTag:(NSInteger )viewTag;
- (void)removeSubViewOfViewTag:(NSInteger )viewTag;
- (BOOL)isTopView:(UIView *)view;
- (BOOL)isSubView:(UIView *)view;
@end
