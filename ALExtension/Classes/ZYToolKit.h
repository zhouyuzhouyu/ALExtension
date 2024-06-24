//
//  ZYDataKit.h
//  AntLive
//
//  Created by yu zhou on 2023/3/21.
//  Copyright © 2023 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYDataKit : NSObject
@end


@interface NSMutableDictionary (SafeSet)
- (void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end

@interface NSMutableArray (SafeAdd)
- (void)safe_addObject:(id)anObject;
@end

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// NSDictionary
id dicGetObject(NSDictionary * dic, id aKey, Class aClass);
NSDictionary * dicGetDic(NSDictionary *dic, id aKey);
NSArray * dicGetArray(NSDictionary *dic, id aKey);
NSString * dicGetString(NSDictionary *dic, id aKey);

int   dicGetInt(NSDictionary *dic, id aKey, int nDefault);
float dicGetFloat(NSDictionary *dic, id aKey, float fDefault);
BOOL  dicGetBool(NSDictionary *dic, id aKey, BOOL bDefault);

// NSArray
id arrGetObject(NSArray *arr, NSUInteger index, Class aClass);
NSDictionary * arrGetDic(NSArray *arr, NSUInteger index);
NSString * arrGetString(NSArray *arr, NSUInteger index);
NSArray * arrGetArray(NSArray *arr, NSUInteger index);


float roundFloat(float price);

NS_ASSUME_NONNULL_END
