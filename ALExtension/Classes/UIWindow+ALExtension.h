//
//  NSString+Paid.h
//  AntLive
//
//  Created by yu zhou on 4/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (ALExtension)
+ (void)addWindowSubview:(UIView *)view;
+ (void)removeWindowSubview;
+ (BOOL)isViewOnMainWindow:(UIView *)view;
+ (UIView *)isViewOfClassOnMainView:(__unsafe_unretained Class)className;
+ (BOOL)windowsWithTopView:(__unsafe_unretained Class)className;
+ (void )windowsRemoveWithTopView:(__unsafe_unretained Class)className;
@end


NS_ASSUME_NONNULL_END
