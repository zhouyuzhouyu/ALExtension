//
//  NSString+Category.h
//  Pandora
//
//  Created by Albert Lee on 12/25/13.
//  Copyright (c) 2013 Albert Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "MHPrettyDate.h"


@interface NSString (ALExtension)
+ (NSString*)timeString:(NSTimeInterval)time;
+ (NSString*)timeString:(NSString *)unixTime format:(MHPrettyDateFormat)format;
+ (NSString*)time:(NSTimeInterval)unixTime format:(MHPrettyDateFormat)format;
+ (NSString *)calendarWithWeekday:(NSTimeInterval)unixTime;
+ (NSString *)calendarString:(NSTimeInterval)unixTime;
+ (NSString *)timeStringFromSec:(int)sec;
+ (NSString *)stringByMD5Encoding:(NSString*)inputString;
+ (NSString *)pathByCacheDirection:(NSString*)customCacheDirectionName;
- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor;
- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor selStr:(NSString *)selStr selFont:(UIFont *)selFont selColor:(UIColor *)selColor;
- (BOOL)containsTraditionalChinese;
- (NSString *)trimWhitespace;
- (NSNumber *)numberValue;
- (NSData *)UTF8Data;
- (NSArray *)getAtNames;
+ (BOOL)stringContainsEmoji:(NSString *)string;
+ (NSString *)timeCountStringByTime:(NSTimeInterval)time;
- (NSString *)convertSingleQuote;
#pragma mark Base64 Related
+ (NSString*)stringWithBase64EncodedString:(NSString *)string;
- (NSString*)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString*)base64EncodedString;
- (NSString*)base64DecodedString;
- (NSData  *)base64DecodedData;
#pragma mark MD5 Related
- (NSString *)MD5;
- (NSData *)getThumnailWithURL:(int)width height:(int)height;
- (UIImage *)getThumnailImageWithURL:(int)width height:(int)height;
+ (NSString *)getFaceImageLocalPathByStoreData:(NSData *)imageData;
+ (NSString *)lineStringByLength:(CGFloat)length font:(CGFloat)fontSize;
#pragma mark 字数判断
+ (int)convertToInt:(NSString*)strtemp;
+ (NSString *)stringWithLimitedChineseCharacter:(NSInteger)length string:(NSString*)strtemp;
- (NSNumber *)stringAntNumber;

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size;
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode;

#pragma mark 拼接URL
-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key;

#pragma mark - time
+(NSString*)showTime:(NSTimeInterval) msglastTime showDetail:(BOOL)showDetail;
+(CALayer *)iconLayerWithRect:(CGRect)rect lineWidth:(CGFloat)w;


@end
