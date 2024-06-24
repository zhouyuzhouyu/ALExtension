//
//  NSNumber+AntLive.m
//  AntLive
//
//  Created by Albert Lee on 08/03/2018.
//  Copyright © 2018 Baobao. All rights reserved.
//

#import "NSNumber+AntLive.h"
#import "NSDate+Utilities.h"
#import "NSDate+ALExtension.h"

@implementation NSNumber (AntLive)
- (NSString *)feedTimeString{
  NSTimeInterval currentTime = [NSDate currentTimeInterval];
  NSTimeInterval feedTime = [self doubleValue];
  
  if (feedTime >= currentTime) {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:currentTime-1];
    NSDateFormatter *formatter = [NSDateFormatter new];
      formatter.dateFormat = @"HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
  }else{
    NSDate *feedDate = [NSDate dateWithTimeIntervalSince1970:feedTime];
    if ([feedDate isToday]) {
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:feedTime];
      NSDateFormatter *formatter = [NSDateFormatter new];
      formatter.dateFormat = @"HH:mm";
      NSString *dateStr = [formatter stringFromDate:date];
      return dateStr;
    }else{
      NSDate *date = [NSDate dateWithTimeIntervalSince1970:feedTime];
      NSDateFormatter *formatter = [NSDateFormatter new];
      formatter.dateFormat = @"MM/dd";
      NSString *dateStr = [formatter stringFromDate:date];
      return dateStr;
    }
  }
}


- (NSString *)quizTimeString{
  NSTimeInterval quizTime = [self doubleValue];
  NSDate *quizDate = [NSDate dateWithTimeIntervalSince1970:quizTime];
  if ([quizDate isToday]) {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    NSString *dateStr = [formatter stringFromDate:quizDate];
    return [NSString stringWithFormat:@"今天 %@",dateStr];
  }else{
    return [self timeString];
  }
}

- (NSString *)countDownString{
  NSInteger countDown = [self integerValue];
  NSInteger sec = MAX(countDown%60, 0);NSString *secString = sec<10?[NSString stringWithFormat:@"0%@",@(sec)]:[@(sec) stringValue];
  NSInteger hour= MAX(countDown/3600, 0);NSString *hourString = hour<10?[NSString stringWithFormat:@"0%@",@(hour)]:[@(hour) stringValue];
  NSInteger min = MAX((countDown - 3600*hour)/60, 0);NSString *minString = min<10?[NSString stringWithFormat:@"0%@",@(min)]:[@(min) stringValue];
  return [NSString stringWithFormat:@"%@：%@：%@",hourString,minString,secString];
}

- (NSString *)countDownStringNoHour{
  NSInteger countDown = [self integerValue];
  NSInteger sec = MAX(countDown%60, 0);NSString *secString = sec<10?[NSString stringWithFormat:@"0%@",@(sec)]:[@(sec) stringValue];
  NSInteger hour= MAX(countDown/3600, 0);
  NSInteger min = MAX((countDown - 3600*hour)/60, 0);NSString *minString = min<10?[NSString stringWithFormat:@"0%@",@(min)]:[@(min) stringValue];
  return [NSString stringWithFormat:@"%@:%@",minString,secString];
}

- (NSString *)liveTimeString{
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateFormat = @"HH:mm";
  NSString *dateStr = [formatter stringFromDate:date];
  return dateStr;
}

- (NSString *)timeFollowOrderString{
    NSTimeInterval currentTime = [NSDate currentTimeInterval];
    NSTimeInterval feedTime = [self doubleValue];
    feedTime = feedTime/1000;
    
    if (currentTime - feedTime <= 60) {
        NSString *dateStr = @"刚刚";
        return dateStr;
    }else if (currentTime - feedTime > 60 && currentTime - feedTime < 3600){
        
        NSString *dateStr = [NSString stringWithFormat:@"%d分钟前",(int)(currentTime - feedTime)/60];
        return dateStr;
    }else if (currentTime - feedTime > 3600){
        return [self timeMDString];
    }return @"";
}


- (NSString *)floatString{
  CGFloat value = [self floatValue];
  NSString *str = [NSString stringWithFormat:@"%.2f",value];
  if ([str rangeOfString:@".00"].location != NSNotFound) {
    str = [str substringToIndex:str.length-3];
  }else if ([[str substringFromIndex:str.length-1] isEqualToString:@"0"]) {
    str = [str substringToIndex:str.length-1];
  }
  return str;
}
- (NSNumber *)float2Number{
    CGFloat value = [self floatValue];
    NSString *str = [NSString stringWithFormat:@"%.2f",value];
    if ([str rangeOfString:@".00"].location != NSNotFound) {
      str = [str substringToIndex:str.length-3];
    }else if ([[str substringFromIndex:str.length-1] isEqualToString:@"0"]) {
      str = [str substringToIndex:str.length-1];
    }
    return @(str.floatValue);
}

- (NSString *)floatStringWithPlusIcon{
  CGFloat value = [self floatValue];
  NSString *str = [NSString stringWithFormat:@"%.2f",value];
  if ([str rangeOfString:@".00"].location != NSNotFound) {
    str = [str substringToIndex:str.length-3];
  }else if ([[str substringFromIndex:str.length-1] isEqualToString:@"0"]) {
    str = [str substringToIndex:str.length-1];
  }
  
  if (value > 0) {
    str = [@"+" stringByAppendingString:str];
  }
  return str;
}


- (NSString *)pointStringByDepositFee:(NSNumber *)depositFee profitPerUnit:(NSNumber *)profitPerUnit{
  if ([self boolValue]) {
    NSInteger point = (NSInteger)(ceilf(([depositFee floatValue] * [self integerValue] / ([profitPerUnit floatValue] * 100.0))));
    return [[@(point) stringValue] stringByAppendingString:@"点"];
  }else{
    return @"无";
  }
}

- (NSString *)pointStringByOpenPrice:(NSNumber *)openPrice profitPerUnit:(NSNumber *)profitPerUnit{
       if (![self isEqualToNumber:openPrice]) {
        NSInteger pointRound= round(([self doubleValue] - [openPrice doubleValue]) / [profitPerUnit doubleValue]) ;
        NSInteger point = (NSInteger) labs(pointRound);
        return [[@(point) floatString] stringByAppendingString:@"点"];
    }else{
        return @"无";
    }
}


- (NSString *)timeString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
- (NSString *)timeCompleteString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSString *)timeCharsString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSString *)timeMMDDString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM.dd HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSString *)timeMDString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
- (NSString *)timeMDStringEx {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/1000];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

@end
