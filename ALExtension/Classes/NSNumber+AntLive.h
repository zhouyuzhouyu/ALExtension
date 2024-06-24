//
//  NSNumber+AntLive.h
//  AntLive
//
//  Created by Albert Lee on 08/03/2018.
//  Copyright © 2018 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (AntLive)
- (NSString *)feedTimeString;
- (NSString *)liveTimeString;
- (NSString *)floatString;
- (NSString *)floatStringWithPlusIcon;
- (NSString *)pointStringByDepositFee:(NSNumber *)depositFee profitPerUnit:(NSNumber *)profitPerUnit;
- (NSString *)pointStringByOpenPrice:(NSNumber *)openPrice profitPerUnit:(NSNumber *)profitPerUnit;
- (NSString *)timeString;
- (NSString *)timeMDStringEx;
- (NSString *)timeCompleteString;
- (NSString *)timeCharsString;
- (NSString *)quizTimeString;
- (NSString *)countDownString;
- (NSString *)timeMMDDString;
- (NSString *)timeMDString;
- (NSString *)countDownStringNoHour;

- (NSString *)timeFollowOrderString;

//保留两位小数
- (NSNumber *)float2Number;

@end
