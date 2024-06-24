//
//  UIImage+Category.m
//  pandora
//
//  Created by Albert Lee on 1/10/14.
//  Copyright (c) 2014 Albert Lee. All rights reserved.
//

#import "UIImage+ALExtension.h"

@implementation UIImage (ALExtension)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
  UIGraphicsBeginImageContext(size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, (CGRect){.size = size});
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
 
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
  return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *) imageWithView:(UIView *)view
{
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  
  UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return img;
}


@end
