//
//  NSString+Category.m
//  Pandora
//
//  Created by Albert Lee on 12/25/13.
//  Copyright (c) 2013 Albert Lee. All rights reserved.
//

#import "NSString+ALExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+ALExtension.h"
#import "NSData+ALExtension.h"
#import <AVFoundation/AVFoundation.h>
#import "NSArray+ALExtension.h"
#import "UIColor+ALExtension.h"


@implementation NSString (ALExtension)
+ (NSString*)timeString:(NSTimeInterval)time{
  [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterFullStyle];
  [dateFormatter setTimeStyle:NSDateFormatterFullStyle];
  return [NSString stringWithFormat:@"?%@",[dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]]];
}

+ (NSString*)timeString:(NSString *)unixTime format:(MHPrettyDateFormat)format{
  return [NSString time:[unixTime doubleValue] format:format];
}

+ (NSString*)time:(NSTimeInterval)unixTime format:(MHPrettyDateFormat)format{
  if (unixTime==0) {
    return @"";
  }
  
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTime];
  NSString *timeString = [MHPrettyDate prettyDateFromDate:date
                                               withFormat:format];
  
  if (format == MHPrettyDateShortRelativeTime && ![[timeString substringFromIndex:timeString.length-1] isEqualToString:@"前"]) {
    timeString = [timeString stringByAppendingString:@"前"];
  }
  
  if (timeString.length>0 && [timeString characterAtIndex:0] == '-') {
    return [timeString substringFromIndex:1];
  }
  
  return timeString;
}

+ (NSString *)calendarWithWeekday:(NSTimeInterval)unixTime{
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTime];
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                             fromDate:date];
  
  NSInteger day = [components day];
  NSInteger month = [components month];
  NSInteger year = [components year];
  
  
  NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[NSDate currentTimeInterval]];
  NSCalendar* currentCalendar = [NSCalendar currentCalendar];
  NSDateComponents* currentDateComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                               fromDate:currentDate];
  
  NSInteger currentYear = [currentDateComponents year];
  NSInteger currentDay = [currentDateComponents day];
  NSInteger currentMonth = [currentDateComponents month];
  
  NSString *yearStr = year==currentYear?@"":[NSString stringWithFormat:@"%@年",@(year)];
  
  NSString *suffix = @"";
  if (currentDay == day && currentMonth == month && currentYear == year) {
    suffix = @"今天";
  }else if (currentDay-1 == day && currentMonth == month && currentYear == year){
    suffix = @"昨天";
  }else{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"];
    suffix = [dateFormatter stringFromDate:date];
  }
  
  NSString *timeStr = [NSString stringWithFormat:@"%@%@月%@日 %@",yearStr,@(month),@(day), suffix];
  return timeStr;
}

+ (NSString *)calendarString:(NSTimeInterval)unixTime{
  NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTime];
  NSCalendar* calendar = [NSCalendar currentCalendar];
  NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                             fromDate:date];
  
  NSInteger day = [components day];
  NSInteger month = [components month];
  NSInteger year = [components year];
  
  
  NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[NSDate currentTimeInterval]];
  NSCalendar* currentCalendar = [NSCalendar currentCalendar];
  NSDateComponents* currentDateComponents = [currentCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                               fromDate:currentDate];
  
  NSInteger currentYear = [currentDateComponents year];
  NSString *yearStr = year==currentYear?@"":[NSString stringWithFormat:@"%@年",@(year)];
  NSString *timeStr = [NSString stringWithFormat:@"%@%@月%@日",yearStr,@(month),@(day)];
  return timeStr;
}

+ (NSString *)timeStringFromSec:(int)sec{
  int h = sec/3600;
  int m = (sec-h*3600)/60;
  int s = sec%30;
  NSString *time = h==0?@"":[NSString stringWithFormat:@"%d小时",h];
  time = m==0?[time stringByAppendingString:@""]:[time stringByAppendingString:[NSString stringWithFormat:@"%d分",m]];
  time = s==0?[time stringByAppendingString:@""]:[time stringByAppendingString:[NSString stringWithFormat:@"%d秒",s]];
  return time;
}

- (NSString *)trimWhitespace
{
  NSMutableString *str = [self mutableCopy];
  CFStringTrimWhitespace((CFMutableStringRef)str);
  return str;
}
#pragma mark String MD5 Encoding & Decoding
+ (NSString *)stringByMD5Encoding:(NSString*)inputString{
  const char *cStr = [inputString UTF8String];
  unsigned char result[16];
  CC_MD5(cStr, (CGFloat)strlen(cStr), result); // This is the md5 call
  return [NSString stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
}

- (NSNumber *)numberValue{
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterDecimalStyle];
  return [f numberFromString:self];
}

- (NSData *)UTF8Data
{
  return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSArray *)getAtNames{
  NSMutableArray *substrings = [NSMutableArray new];
  NSScanner *scanner = [NSScanner scannerWithString:self];
  [scanner scanUpToString:@"@" intoString:nil]; // Scan all characters before #
  while(![scanner isAtEnd]) {
    NSString *substring = nil;
    [scanner scanString:@"@" intoString:nil]; // Scan the # character
    if([scanner scanUpToString:@" " intoString:&substring]) {
      // If the space immediately followed the #, this will be skipped
      [substrings addObject:substring];
    }
    [scanner scanUpToString:@"@" intoString:nil]; // Scan all characters before next #
  }
  // do something with substrings
  return substrings;
}

- (NSString *)convertSingleQuote{
  if ([self rangeOfString:@"'"].location != NSNotFound) {
    NSMutableString *str = [@"" mutableCopy];
    for (NSInteger i=0;i<self.length; i++) {
      NSString *subStr = [self substringWithRange:NSMakeRange(i, 1)];
      if ([subStr isEqualToString:@"'"]) {
        [str appendString:@"''"];
      }
      else{
        [str appendString:subStr];
      }
    }
    return [str copy];
  }
  else{
    return self;
  }
}
#pragma mark Cache Path Direction
+ (NSString *)pathByCacheDirection:(NSString*)customCacheDirectionName{
  NSArray *cacheDirectoryArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *pathString = [cacheDirectoryArray objectAtIndex:0];
  NSString *customCacheDirection = [pathString stringByAppendingPathComponent:customCacheDirectionName];
  if (![[NSFileManager defaultManager] fileExistsAtPath:customCacheDirection])
  {
    [[NSFileManager defaultManager] createDirectoryAtPath:customCacheDirection
                              withIntermediateDirectories:NO
                                               attributes:nil
                                                    error:nil];
  }
  
  return customCacheDirection;
}

+ (BOOL)stringContainsEmoji:(NSString *)string {
  __block BOOL returnValue = NO;
  [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
   ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
     
     const unichar hs = [substring characterAtIndex:0];
     // surrogate pair
     if (0xd800 <= hs && hs <= 0xdbff) {
       if (substring.length > 1) {
         const unichar ls = [substring characterAtIndex:1];
         const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
         if (0x1d000 <= uc && uc <= 0x1f77f) {
           returnValue = YES;
         }
       }
     } else if (substring.length > 1) {
       const unichar ls = [substring characterAtIndex:1];
       if (ls == 0x20e3) {
         returnValue = YES;
       }
       
     } else {
       // non surrogate
       if (0x2100 <= hs && hs <= 0x27ff) {
         returnValue = YES;
       } else if (0x2B05 <= hs && hs <= 0x2b07) {
         returnValue = YES;
       } else if (0x2934 <= hs && hs <= 0x2935) {
         returnValue = YES;
       } else if (0x3297 <= hs && hs <= 0x3299) {
         returnValue = YES;
       } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
         returnValue = YES;
       }
     }
   }];
  
  return returnValue;
}

+ (NSString *)timeCountStringByTime:(NSTimeInterval)time{
  int h = time/3600;
  int m = (time-h*3600)/60;
  int s = time-h*3600-m*60;
  
  NSString *hStr = h<10?[NSString stringWithFormat:@"0%d",h]:[NSString stringWithFormat:@"%d",h];
  NSString *mStr = m<10?[NSString stringWithFormat:@"0%d",m]:[NSString stringWithFormat:@"%d",m];
  NSString *sStr = s<10?[NSString stringWithFormat:@"0%d",s]:[NSString stringWithFormat:@"%d",s];
  
  NSString *callingTime = @"";
  if (h>0) {
    callingTime = [NSString stringWithFormat:@"%@:%@:%@",hStr,mStr,sStr];
  }
  else{
    callingTime = [NSString stringWithFormat:@"%@:%@",mStr,sStr];
  }
  return callingTime;
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor{
  NSMutableAttributedString *mut = [[NSMutableAttributedString alloc] initWithString:self
                                                                          attributes:@{NSFontAttributeName:font,
                                                                                       NSForegroundColorAttributeName:textColor
                                                                                       }];
  return mut;
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font textColor:(UIColor *)textColor selStr:(NSString *)selStr selFont:(UIFont *)selFont selColor:(UIColor *)selColor{
    NSMutableAttributedString *mut = [[NSMutableAttributedString alloc] initWithString:self
                                                                            attributes:@{NSFontAttributeName:font,
                                                                                         NSForegroundColorAttributeName:textColor
                                                                                         }];
    NSRange range = [self rangeOfString:selStr];
    if (range.location != NSNotFound) {
        NSInteger location = range.location;
        NSInteger lenght = range.length;
        [mut addAttribute:NSForegroundColorAttributeName value:selColor range:NSMakeRange(location, lenght)];
        [mut addAttribute:NSFontAttributeName value:selFont range:NSMakeRange(location, lenght)];
    }
    
    return mut;
}




#pragma mark Traditional Chinese Character
- (BOOL)containsTraditionalChinese{
  //  for (NSInteger i=0;i<[self length];i++) {
  //
  //  }
  
  return NO;
}

#pragma mark MD5 Related
- (NSString *)MD5
{
  const char *cStr = [self UTF8String];
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
  return [NSString stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
}


#pragma mark Base64 Related

+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
  NSData *data = [NSData dataWithBase64EncodedString:string];
  if (data)
  {
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
  }
  return nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  return [data base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)base64EncodedString
{
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  return [data base64EncodedString];
}

- (NSString *)base64DecodedString
{
  return [NSString stringWithBase64EncodedString:self];
}

- (NSData *)base64DecodedData
{
  return [NSData dataWithBase64EncodedString:self];
}

- (NSData *)getThumnailWithURL:(int)width height:(int)height{
  NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
  NSURL *url=[[NSURL alloc]initWithString:self];
  AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
  AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
  generator.appliesPreferredTrackTransform = YES;
  generator.maximumSize = CGSizeMake(width, height);
  NSError *error = nil;
  CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(25, 25) actualTime:NULL error:&error]; // 截图第一秒视频帧
  UIImage *image = [UIImage imageWithCGImage: img];
  return UIImageJPEGRepresentation(image,1.0);;
}

- (UIImage *)getThumnailImageWithURL:(int)width height:(int)height{
  NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
  NSURL *url=[[NSURL alloc]initWithString:self];
  AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
  AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
  generator.appliesPreferredTrackTransform = YES;
  generator.maximumSize = CGSizeMake(width, height);
  NSError *error = nil;
  CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(25, 25) actualTime:NULL error:&error]; // 截图第一秒视频帧
  UIImage *image = [UIImage imageWithCGImage: img];
  return image;
}

+ (NSString *)getFaceImageLocalPathByStoreData:(NSData *)imageData{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
  NSString *imageLocalPath = [paths safeObjectAtIndex:0];
  imageLocalPath = [imageLocalPath stringByAppendingPathComponent:[[NSString stringByMD5Encoding:[NSString stringWithFormat:@"%@%@",@"FaceCamera",[NSString timeString:[NSDate currentTimeInterval]]]] stringByAppendingString:@".jpg"]];
  
  BOOL succeed = [imageData writeToFile:imageLocalPath atomically:YES];
  
  if (!succeed) {
    NSLog(@"write local image failed");
  }
  else{
    NSLog(@"%@",imageLocalPath);
  }
  return imageLocalPath;
}

+ (NSString *)lineStringByLength:(CGFloat)length font:(CGFloat)fontSize{
  NSString *line = @"_";
  CGSize size = [line sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
  NSInteger count = length/size.width;
  while (count>0) {
    line= [line stringByAppendingString:@"_"];
    count--;
  }
  return line;
}
#pragma mark 字数判断
+ (int)convertToInt:(NSString*)strtemp {
  int strlength = 0;
  char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
  for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
    if (*p) {
      p++;
      strlength++;
    }
    else {
      p++;
    }
  }
  return (strlength+1)/2;
}
+ (NSString *)stringWithLimitedChineseCharacter:(NSInteger)length string:(NSString*)strtemp{
  int strlength = 0;
  char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
  for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
    if (*p) {
      p++;
      strlength++;
      if (((strlength+1)/2)>=length) {
        return [strtemp substringToIndex:i];
      }
    }
    else {
      p++;
    }
  }
  return strtemp;
}

- (NSNumber *)stringAntNumber{
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSInteger remainSecond = [[self stringByTrimmingCharactersInSet:nonDigits] intValue];
    return @(remainSecond);
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode{
  NSMutableDictionary *attrNew = [attrs mutableCopy];
  NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
  paragraph.lineBreakMode = mode;
  [attrNew setObject:paragraph forKey:NSParagraphStyleAttributeName];
  
  CGSize resultSize = CGSizeZero;
  @try {
    resultSize = [self boundingRectWithSize:size
                                    options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attrNew context:nil].size;
  } @catch (NSException *exception) {
  } @finally {
    return resultSize;
  }
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size{
  CGSize resultSize = CGSizeZero;
  @try {
    resultSize = [self boundingRectWithSize:size
                                    options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attrs context:nil].size;
  } @catch (NSException *exception) {
  } @finally {
    return resultSize;
  }
}



#pragma mark 拼接URL
-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key{
    NSMutableString *string = [[NSMutableString alloc]initWithString:self];
    @try {
        NSRange range = [string rangeOfString:@"?"];
        if (range.location != NSNotFound) {//找到了
            //如果?是最后一个直接拼接参数
            if (string.length == (range.location + range.length)) {
                NSLog(@"最后一个是?");
                string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果不是最后一个需要加&
                if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
                }else{//如果最后不是&,需要加&后拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
                }
            }
        }else{//没找到
            if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
                string = (NSMutableString *)[string substringToIndex:string.length-1];
            }
            string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    
    return string.copy;
}

+(NSString*)showTime:(NSTimeInterval) msglastTime showDetail:(BOOL)showDetail
{
    //今天的时间
    NSDate * nowDate = [NSDate date];
    NSDate * msgDate = [NSDate dateWithTimeIntervalSince1970:msglastTime/1000];
    NSString *result = nil;
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *nowDateComponents = [[NSCalendar currentCalendar] components:components fromDate:nowDate];
    NSDateComponents *msgDateComponents = [[NSCalendar currentCalendar] components:components fromDate:msgDate];
    
    NSInteger hour = msgDateComponents.hour;
    
    result = [NSString getPeriodOfTime:hour withMinute:msgDateComponents.minute];
    if (hour > 12)
    {
        hour = hour - 12;
    }
    if(nowDateComponents.day == msgDateComponents.day) //同一天,显示时间
    {
        result = showDetail?[[NSString alloc] initWithFormat:@"%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute]:@"今天";
    }
    else if(nowDateComponents.day == (msgDateComponents.day+1))//昨天
    {
        result = showDetail?  [[NSString alloc] initWithFormat:@"昨天%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute] : @"昨天";
    }
    else if(nowDateComponents.day == (msgDateComponents.day+2)) //前天
    {
        result = showDetail? [[NSString alloc] initWithFormat:@"前天%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute] : @"前天";
    }
    else if([nowDate timeIntervalSinceDate:msgDate] < 7 * (24*60*60))//一周内
    {
        NSString *weekDay = [NSString weekdayStr:msgDateComponents.weekday];
        result = showDetail? [weekDay stringByAppendingFormat:@"%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute] : weekDay;
    }
    else//显示日期
    {
        NSString *day = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)msgDateComponents.year, (long)msgDateComponents.month, (long)msgDateComponents.day];
        result = showDetail? [day stringByAppendingFormat:@"%@ %ld:%02d",result,(long)hour,(int)msgDateComponents.minute]:day;
    }
    return result;
}


+ (NSString *)getPeriodOfTime:(NSInteger)time withMinute:(NSInteger)minute
{
    NSInteger totalMin = time *60 + minute;
    NSString *showPeriodOfTime = @"";
    if (totalMin > 0 && totalMin <= 5 * 60)
    {
        showPeriodOfTime = @"凌晨";
    }
    else if (totalMin > 5 * 60 && totalMin < 12 * 60)
    {
        showPeriodOfTime = @"上午";
    }
    else if (totalMin >= 12 * 60 && totalMin <= 18 * 60)
    {
        showPeriodOfTime = @"下午";
    }
    else if ((totalMin > 18 * 60 && totalMin <= (23 * 60 + 59)) || totalMin == 0)
    {
        showPeriodOfTime = @"晚上";
    }
    return showPeriodOfTime;
}

+(NSString*)weekdayStr:(NSInteger)dayOfWeek
{
    static NSDictionary *daysOfWeekDict = nil;
    daysOfWeekDict = @{@(1):@"星期日",
                       @(2):@"星期一",
                       @(3):@"星期二",
                       @(4):@"星期三",
                       @(5):@"星期四",
                       @(6):@"星期五",
                       @(7):@"星期六",};
    return [daysOfWeekDict objectForKey:@(dayOfWeek)];
}



+(CALayer *)iconLayerWithRect:(CGRect)rect lineWidth:(CGFloat)w{
    CGRect bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
    //创建背景圆环
    CAShapeLayer *trackLayer = [CAShapeLayer layer];
    trackLayer.frame = bounds;
    //清空填充色
    trackLayer.fillColor = [UIColor clearColor].CGColor;
    
    //设置画笔颜色 即圆环背景色
    trackLayer.strokeColor =  [UIColor colorWithRed:170/255.0 green:210/255.0 blue:254/255.0 alpha:1].CGColor;
    trackLayer.lineWidth = w;
    
    //设置画笔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0) radius:bounds.size.width/2.0 - w*0.5 startAngle:- M_PI_2 endAngle:-M_PI_2 + M_PI * 2 clockwise:YES];
    //path 决定layer将被渲染成何种形状
    trackLayer.path = path.CGPath;
    
    CALayer *gradientLayer = [CALayer layer];
    //    gradientLayer.frame = rect;
    
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = bounds;
    
    gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRGBHex:0x1941FF].CGColor, (__bridge id)[UIColor colorWithRGBHex:0xFF0000].CGColor];
    //startPoint和endPoint属性，他们决定了渐变的方向。这两个参数是以单位坐标系进行的定义，所以左上角坐标是{0, 0}，右下角坐标是{1, 1}
    //startPoint和pointEnd 分别指定颜色变换的起始位置和结束位置.
    //当开始和结束的点的x值相同时, 颜色渐变的方向为纵向变化
    //当开始和结束的点的y值相同时, 颜色渐变的方向为横向变化
    //其余的 颜色沿着对角线方向变化
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 0);
    [gradientLayer addSublayer:gradientLayer1];
    
    gradientLayer.mask = trackLayer;
    return gradientLayer;
}

@end
