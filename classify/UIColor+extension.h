//
//  UIColor+extension.h
//  CCEnglish
//
//  Created by 张杰 on 16/3/6.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extension)


+ (UIColor*) colorWithHex:(NSString *)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSString *)hexValue;
@end
