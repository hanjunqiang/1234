//
//  FBT_ProgressView.m
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_ProgressView.h"

@implementation FBT_ProgressView

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];

}

- (void)setProgressColor:(UIColor *)progressColor
{
    
    _progressColor = progressColor;
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //拼接路径
    CGPoint center = CGPointMake(25, 25);
    CGFloat radius = 23;
    CGFloat startA = -M_PI_2;
    CGFloat endA = -M_PI_2 +_progress*(M_PI*2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    CGContextSetLineCap(ctx, 4);
    //把路径添加到上下文
    [[UIColor redColor] set];
    if (self.progressColor) {
        [self.progressColor set];
    }
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetLineWidth(ctx, 4);
    
    //把上下文渲染到视图上
    CGContextStrokePath(ctx);
}

@end
