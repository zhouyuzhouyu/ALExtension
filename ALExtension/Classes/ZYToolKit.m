//
//  ZYDataKit.m
//  AntLive
//
//  Created by yu zhou on 2023/3/21.
//  Copyright © 2023 Baobao. All rights reserved.
//

#import "ZYToolKit.h"

@implementation NSMutableDictionary (SafeSet)

- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (aKey) {
        if (!anObject) {
            [self removeObjectForKey:aKey];
        }
        else {
            [self setObject:anObject forKey:aKey];
        }
    }
}

@end

@implementation NSMutableArray (SafeAdd)

- (void)safe_addObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#pragma mark - - NSDictionary get object
// - - -
id dicGetObject(NSDictionary * dic, id aKey, Class aClass) {
    id result = [dic objectForKey:aKey];
    if (result && [result isKindOfClass:aClass]) {
        return result;
    }
    return nil;
}

// - - -
NSDictionary * dicGetDic(NSDictionary *dic, id aKey) {
    return (NSDictionary *)dicGetObject(dic, aKey, [NSDictionary class]);
}

NSArray * dicGetArray(NSDictionary *dic, id aKey) {
    return (NSArray *)dicGetObject(dic, aKey, [NSArray class]);
}

// - - -
NSString * dicGetString(NSDictionary *dic, id aKey) {
    if (dic == nil || ![dic isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    id result = [dic objectForKey:aKey];
    if (result && [result isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",result];
    } else if (result && [result isKindOfClass:[NSString class]]) {
        return (NSString *)result;
    }
    return @"";
}


// - - -
int dicGetInt(NSDictionary *dic, id aKey, int nDefault) {
    if (dic) {
        id result = [dic objectForKey:aKey];
        if (result && [result isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)result intValue];
        }
        else if (result && [result isKindOfClass:[NSString class]]) {
            return [(NSString *)result intValue];
        }
    }
    return nDefault;
}

float dicGetFloat(NSDictionary *dic, id aKey, float fDefault) {
    if (dic) {
        id result = [dic objectForKey:aKey];
        if (result && [result isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)result floatValue];
        }
        else if (result && [result isKindOfClass:[NSString class]]) {
            return [(NSString *)result floatValue];
        }
    }
    return fDefault;
}

BOOL dicGetBool(NSDictionary *dic, id aKey, BOOL bDefault) {
    if (dic) {
        id result = [dic objectForKey:aKey];
        if (result && [result isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)result boolValue];
        }
        else if (result && [result isKindOfClass:[NSString class]]) {
            return [(NSString *)result boolValue];
        }
    }
    return bDefault;
}

#pragma mark - - NSArray get object
// - - - -
id arrGetObject(NSArray *arr, NSUInteger index, Class aClass) {
    NSDictionary *result = nil;
    if (index < arr.count) {
        result = [arr objectAtIndex:index];
        if (result && [result isKindOfClass:aClass]) {
            return result;
        }
    }
    return nil;
}

// - - -
NSDictionary * arrGetDic(NSArray *arr, NSUInteger index) {
    NSDictionary *result = nil;
    if ( index<arr.count ) {
        result = [arr objectAtIndex:index];
        if ( result && [result isKindOfClass:[NSDictionary class]] ) {
            return result;
        }
    }
    return nil;
}

NSString * arrGetString(NSArray *arr, NSUInteger index) {
    id object = arrGetObject(arr, index, [NSObject class]);
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",object];
    }
    return @"";
}

NSArray * arrGetArray(NSArray *arr, NSUInteger index) {
    return arrGetObject(arr, index, [NSArray class]);
}

float roundFloat(float price) {
    return roundf(price*100)/100;
}
