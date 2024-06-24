//
//  NSDate+ALExtension.m
//  ALExtension
//
//  Created by Albert Lee on 4/7/15.
//  Copyright (c) 2015 Albert Lee. All rights reserved.
//

#import "NSDate+ALExtension.h"

@implementation NSDate (ALExtension)
+ (NSTimeInterval)currentTimeInterval{
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
  return currentTime;
}

+ (long)currentLongTimeInterval{
    return (long)round([self currentTimeInterval] *1000);
}

@end
