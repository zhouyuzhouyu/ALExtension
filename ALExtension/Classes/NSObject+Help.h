//
//  NSObject+RealClass.h
//  homework
//
//  Created by panxiang on 14-6-27.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Help)
+ (Class)realClass:(Class)className;
+ (void)swizzledClass:(Class)aclass
     originalSelector:(SEL)originalSelector
          altSelector:(SEL)altSelector
        isClassMethod:(BOOL)isClassMethod;
- (BOOL)hasNilObject:(const id <NSCopying> [])objects count:(NSInteger)cnt;
+ (BOOL)hasNilObject:(const id <NSCopying> [])objects count:(NSInteger)cnt;
@end
