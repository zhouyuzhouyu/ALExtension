//
//  NSString+AntLive.m
//  AntLive
//
//  Created by Albert Lee on 05/03/2018.
//  Copyright © 2018 Baobao. All rights reserved.
//

#import "NSString+AntLive.h"

@implementation NSString (AntLive)
- (NSString *)timeString{
  return [self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
}

- (NSString *)replacingString:(NSString *)str{
    NSRange range = [self rangeOfString:str];
    if ((range.location != NSNotFound) ) {
         return [self stringByReplacingOccurrencesOfString:str withString:@""];
    }
    return self;
}


- (NSString *)voucherTimeString{
    NSRange range = [self rangeOfString:@"T"];
    return [self substringWithRange:NSMakeRange(0, range.location)];;
}

- (NSDate *)stringToDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}


- (BOOL)isValidPassword{
  NSCharacterSet *validChars = [NSCharacterSet alphanumericCharacterSet];
  NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
  BOOL valid = [validChars isSupersetOfSet:inStringSet];
  return valid;
}

- (BOOL)isAllDigits{
  NSCharacterSet *validChars = [NSCharacterSet decimalDigitCharacterSet];
  NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:self];
  BOOL valid = [validChars isSupersetOfSet:inStringSet];
  return valid;
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
  value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  NSInteger length =0;
  if (!value) {
    return NO;
  }else {
    length = value.length;
    
    if (length !=15 && length !=18) {
      return NO;
    }
  }
  // 省份代码
  NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
  
  NSString *valueStart2 = [value substringToIndex:2];
  BOOL areaFlag =NO;
  for (NSString *areaCode in areasArray) {
    if ([areaCode isEqualToString:valueStart2]) {
      areaFlag =YES;
      break;
    }
  }
  
  if (!areaFlag) {
    return false;
  }
  
  
  NSRegularExpression *regularExpression;
  NSUInteger numberofMatch;
  
  int year =0;
  switch (length) {
    case 15:{
      year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
      
      if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
        
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
      }else {
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
      }
      numberofMatch = [regularExpression numberOfMatchesInString:value
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, value.length)];
      
      //            [regularExpressionrelease];
      
      if(numberofMatch >0) {
        return YES;
      }else {
        return NO;
      }
      
    }
      break;
    case 18:{
      
      year = [value substringWithRange:NSMakeRange(6,4)].intValue;
      if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
        
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
      }else {
        regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                options:NSRegularExpressionCaseInsensitive
                                                                  error:nil];//测试出生日期的合法性
      }
      numberofMatch = [regularExpression numberOfMatchesInString:value
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, value.length)];
      
      
      if(numberofMatch >0) {
        int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
        int Y = S %11;
        NSString *M =@"F";
        NSString *JYM =@"10X98765432";
        M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
        if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
          return YES;// 检测ID的校验位
        }else {
          return NO;
        }
        
      }else {
        return NO;
      }
      
    }
      break;
    default:
      return false;
  }
}
@end
