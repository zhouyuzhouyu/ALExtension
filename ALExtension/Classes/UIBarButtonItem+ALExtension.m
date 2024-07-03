//
//  UIBarButtonItem+ALExtension.m
//  ALExtension
//
//  Created by Albert Lee on 4/7/15.
//  Copyright (c) 2015 Albert Lee. All rights reserved.
//

#import "UIBarButtonItem+ALExtension.h"
#import "UIView+ALExtension.h"

@implementation UIBarButtonItem (ALExtension)
#pragma mark Navigation Item
+ (NSArray *)loadBarButtonItemWithTitle:(NSString*)title
                                  color:(UIColor*)textColor
                                   font:(UIFont*)font
                                 target:(id)target
                                 action:(SEL)action
                                 offset:(CGFloat)offset{
  UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                     target:nil action:nil];
  if (offset!=0) {
    negativeSpacer.width = offset;
  }else{
    negativeSpacer.width = 0;
  }

    UIBarButtonItem *bbtn;
    CGFloat offsetX = 10;
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, MAX(70, size.width), 40)];
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = title;
    lblTitle.textColor = textColor;
    lblTitle.textAlignment = NSTextAlignmentRight;
    lblTitle.font = font;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, lblTitle.width, 40) ];
    [view addSubview:lblTitle];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tapGesture];
    
    bbtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    return @[negativeSpacer,bbtn];
}

+ (UIBarButtonItem*)loadBarButtonItemWithImage:(NSString*)imageName rect:(CGRect)rect arget:(id)target action:(SEL)action{

    UIBarButtonItem *bbtn;
    
    UIView *view=[[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    view.frame = imageView.bounds;
    [view addSubview:imageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tapGesture];
    
    bbtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    return bbtn;
}

+ (UIBarButtonItem*)loadRightBarButtonItemWithImage:(NSString*)imageName rect:(CGRect)rect target:(id)target action:(SEL)action{

    UIBarButtonItem *bbtn;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = rect;
    [view addSubview:imageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tapGesture.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:tapGesture];
    view.userInteractionEnabled = YES;
    
    bbtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    return bbtn;
}

+ (UIBarButtonItem *)loadBackButtonWithTarget:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"chevron.backward" withConfiguration:[UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightSemibold]] style:UIBarButtonItemStylePlain target:target action:action];
}

+ (UIBarButtonItem *)loadCloseButtonWithTarget:(id)target action:(SEL)action {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"xmark" withConfiguration:[UIImageSymbolConfiguration configurationWithWeight:UIImageSymbolWeightSemibold]] style:UIBarButtonItemStylePlain target:target action:action];
}


@end
