//
//  NSString+Paid.m
//  AntLive
//
//  Created by yu zhou on 4/3/24.
//

#import <Foundation/Foundation.h>

@implementation UIFont (ALExtension)
+ (UIFont *)antLiveBoldFontWithSize:(CGFloat)fontSize{
  UIFont *font = [UIFont fontWithName:@"DIN-Bold" size:fontSize];
  return font;
}
+ (UIFont *)antLiveLightFontWithSize:(CGFloat)fontSize{
  UIFont *font = [UIFont fontWithName:@"DIN-Light" size:fontSize];
  return font;
}
+ (UIFont *)antLiveFontWithSize:(CGFloat)fontSize{
  UIFont *font = [UIFont fontWithName:@"DIN-Medium" size:fontSize];
  return font;
}
+ (UIFont *)antLivePingFangSCSemiboldWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    return font;
}
+ (UIFont *)antLivePingFangSCMediumWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Medium" size:fontSize];
    return font;
}
+ (UIFont *)antLivePingFangSCRegularWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:fontSize];
    return font;
}
+ (UIFont *)antLivePingFangSCLightWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Light" size:fontSize];
    return font;
}


+ (UIFont *)antLiveFontnName:(NSString *)fontName WithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font;
}


@end





