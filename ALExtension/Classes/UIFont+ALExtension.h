//
//  NSString+Paid.h
//  AntLive
//
//  Created by yu zhou on 4/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ALExtension)
+ (UIFont *)antLiveBoldFontWithSize:(CGFloat)fontSize;
+ (UIFont *)antLiveLightFontWithSize:(CGFloat)fontSize;
+ (UIFont *)antLiveFontWithSize:(CGFloat)fontSize;

+ (UIFont *)antLivePingFangSCSemiboldWithSize:(CGFloat)fontSize;
+ (UIFont *)antLivePingFangSCRegularWithSize:(CGFloat)fontSize;
+ (UIFont *)antLivePingFangSCLightWithSize:(CGFloat)fontSize;
+ (UIFont *)antLivePingFangSCMediumWithSize:(CGFloat)fontSize;
+ (UIFont *)antLiveFontnName:(NSString *)fontName WithSize:(CGFloat)fontSize;
@end


NS_ASSUME_NONNULL_END
