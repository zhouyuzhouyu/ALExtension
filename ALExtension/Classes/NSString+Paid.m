//
//  NSString+Paid.m
//  AntLive
//
//  Created by yu zhou on 4/3/24.
//

#import <Foundation/Foundation.h>
#import <sys/stat.h>
#import <sys/sysctl.h>
#import "NSString+ALExtension.h"


//NSString* paid(NSString *abc) {
//    struct stat info;
//    int result = stat("/var/mobile", &info);
//    if (result!=0) {
//        return @"";
//    }
//    struct timespec time = info.st_birthtimespec;
//    return [NSString stringWithFormat:@"%ld.%09ld", time.tv_sec, time.tv_nsec];
//}

time_t bootSecTime(NSString *abc){
    struct timeval boottime;
    size_t len = sizeof(boottime);
    int mib[2] = { CTL_KERN, KERN_BOOTTIME };
    if( sysctl(mib, 2, &boottime, &len, NULL, 0) < 0 ) {
        return 0;
    }
    return boottime.tv_sec;
}


@implementation NSString (Paid)
+ (NSString *)paid {
    NSString *paid1 = [self getFileTime];
    NSString *paid2 = [self getSysU];
    NSString *paid3 = [self bootTimeInSec];
    
    NSString *result = [NSString stringWithFormat:@"%@-%@-%@", [paid1 MD5], [paid2 MD5], [paid3 MD5]];
    NSLog(@"---PAID----\n%@", result);
    return result;
}

+ (NSString *)getFileTime {
    struct stat info;
    int result = stat("/var/mobile", &info);
    if (result!=0) {
        return @"";
    }
    struct timespec time = info.st_birthtimespec;
    return [NSString stringWithFormat:@"%ld.%09ld", time.tv_sec, time.tv_nsec];
}


+(NSString *)getSysU {
    NSString *result = nil;
    NSString *information = @"L3Zhci9tb2JpbGUvTGlicmFyeS9Vc2VyQ29uZmlndXJhdGlvblByb2ZpbGVzL1B1YmxpY0luZm8vTUNNZXRhLnBsaXN0";
    NSData *data=[[NSData alloc]initWithBase64EncodedString:information options:0];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:dataString error:&error];
    if (fileAttributes) {
        id singleAttibute = [fileAttributes objectForKey:NSFileCreationDate];
        if ([singleAttibute isKindOfClass:[NSDate class]]) {
            NSDate *dataDate = singleAttibute; 
            result = [NSString stringWithFormat:@"%.6f",[dataDate timeIntervalSince1970]];
        }
    }
    return result;
}


+(NSString *)bootTimeInSec {
    return [NSString stringWithFormat:@"%ld", bootSecTime(@"")];
}

@end





