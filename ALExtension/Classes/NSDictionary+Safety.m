//
//  NSDictionary+Safety.m
//  homework
//
//  Created by panxiang on 14-6-27.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "NSDictionary+Safety.h"
#import <objc/runtime.h>
#import "NSObject+Help.h"

@implementation NSDictionary (Safety)

- (void)printNotValidKeyError:(const char *)fuction
{
    [[self class] printNotValidKeyError:fuction];
}

+ (void)printNotValidKeyError:(const char *)fuction
{
    NSLog(@"%s \n key is not confirm NSCopying protocol \n Dictionary:%@",fuction ,self);
}

- (void)printNilKeyError:(const char *)fuction
{
    [[self class] printNilKeyError:fuction];
}

- (void)printNilObjectError:(const char *)fuction
{
    [[self class] printNilObjectError:fuction];
}

+ (void)printNilObjectError:(const char *)fuction
{
    NSLog(@"%s \n object is nil \n Dictionary:%@",fuction ,self);
}

+ (void)printNilKeyError:(const char *)fuction
{
    NSLog(@"%s \n key is nil \n Dictionary:%@",fuction ,self);
}

- (id)valueForKeySafely:(id)aKey
{
    if (!aKey) {
        [self printNilKeyError:__FUNCTION__];
        return nil;
    }
    return [self valueForKey:aKey];
}

- (void)setValue:(id)value forKeySafely:(NSString *)key
{
    if (!key) {
        [self printNilKeyError:__FUNCTION__];
    }
    return [self setValue:value forKey:key];
}


+ (id)sharedKeySetForKeysSafely:(NSArray *)keys
{
    if (!keys) {
        [self printNilKeyError:__FUNCTION__];
        return nil;
    }
    return [self sharedKeySetForKeys:keys];
}

- (id)objectForKeySafely:(id)aKey
{
    if (!aKey) {
        [self printNilKeyError:__FUNCTION__];
        return nil;
    }
    return [self objectForKey:aKey];
}

- (id)objectForKeyedSubscriptSafely:(id)key
{
    if (!key) {
        [self printNilKeyError:__FUNCTION__];
        return nil;
    }
    return [self objectForKeyedSubscript:key];
}

- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarkerSafely:(id)marker
{
    if (!marker) {
        [self printNilObjectError:__FUNCTION__];
        return nil;
    }
    return [self objectsForKeys:keys notFoundMarker:marker];
}

+ (instancetype)dictionaryWithObject:(id)object forKeySafely:(id <NSCopying>)key
{
    if (!object) {
        [self printNilObjectError:__FUNCTION__];
        return [[self class] dictionary];
    }
    if (!key) {
        [self printNilKeyError:__FUNCTION__];
        return [[self class] dictionary];
    }
    return [self dictionaryWithObject:object forKey:key];
}



@end


@implementation NSMutableDictionary (Safety)

- (void)removeObjectForKeySafely:(id)aKey
{

    
    if (!aKey)
    {
        [self printNilKeyError:__FUNCTION__];
        return;
    }
    [self removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKeySafely:(id <NSCopying>)aKey
{
    if (!anObject) {
        [self printNilObjectError:__FUNCTION__];
        return;
    }
    
    if (!aKey) {
        [self printNilKeyError:__FUNCTION__];
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

- (void)setObject:(id)obj forKeyedSubscriptSafely:(id <NSCopying>)key
{
    if (!obj) {
        [self printNilObjectError:__FUNCTION__];
        return;
    }
    
    if (!key) {
        [self printNilKeyError:__FUNCTION__];
        return;
    }
    
    [self setObject:obj forKeyedSubscript:key];
}
@end
