//
//  UIColor+extension.m
//  CCEnglish
//
//  Created by 张杰 on 16/3/6.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "UIColor+extension.h"

@implementation UIColor (extension)

+ (UIColor*) colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue
{
    NSInteger value = hexValue.integerValue;

    return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0
                           green:((float)((value & 0xFF00) >> 8))/255.0
                            blue:((float)(value & 0xFF))/255.0 alpha:alphaValue];
}


+ (UIColor*) colorWithHex:(NSString *)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

@end
