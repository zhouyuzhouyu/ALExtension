//
//  UIImage+Category.h
//  pandora
//
//  Created by Albert Lee on 1/10/14.
//  Copyright (c) 2014 Albert Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALExtension)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *) imageWithView:(UIView *)view;
@end
