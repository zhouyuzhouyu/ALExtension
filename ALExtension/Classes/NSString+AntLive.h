//
//  NSString+AntLive.h
//  AntLive
//
//  Created by Albert Lee on 05/03/2018.
//  Copyright © 2018 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AntLive)
- (NSDate *)stringToDateFormat:(NSString *)format;
- (NSString *)timeString;
- (NSString *)replacingString:(NSString *)str;
- (NSString *)voucherTimeString;
- (BOOL)isValidPassword;
- (BOOL)isAllDigits;
+ (BOOL)validateIDCardNumber:(NSString *)value;
@end
