//
//  NSAttributedString+ALExtension.m
//  AntLive
//
//  Created by Albert Lee on 19/03/2018.
//  Copyright © 2018 Baobao. All rights reserved.
//

#import "NSAttributedString+ALExtension.h"

@implementation NSAttributedString (ALExtension)
- (CGSize)sizeWithConstrainedToSize:(CGSize)size{
  CGSize resultSize = CGSizeZero;
  @try {
    resultSize = [self boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    context:nil].size;
    resultSize = CGSizeMake(round(resultSize.width) + 1, round(resultSize.height) + 1);
  } @catch (NSException *exception) {
  } @finally {
    return resultSize;
  }
}
@end
