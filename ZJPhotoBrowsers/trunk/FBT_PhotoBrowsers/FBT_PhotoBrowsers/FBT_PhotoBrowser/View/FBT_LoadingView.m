//
//  FBT_LoadingView.m
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_LoadingView.h"
#import "FBT_ProgressView.h"
#import "UIView+Extension.h"


#define Kwidth   [UIScreen mainScreen].bounds.size.width
#define KHeight   [UIScreen mainScreen].bounds.size.height

@interface FBT_LoadingView()

@property (nonatomic, strong) FBT_ProgressView *progressView;
@property (nonatomic, strong) UILabel *failLabel;

@end

@implementation FBT_LoadingView

- (FBT_ProgressView *)progressView
{
    if (!_progressView) {
        
        _progressView = [[FBT_ProgressView alloc]init];
        _progressView.width = _progressView.height = 60;
    }
    return _progressView;
}

- (UILabel *)failLabel
{
    if (!_failLabel) {
        
        _failLabel = [[UILabel alloc]init];
        _failLabel.text = @"网络不给力，图片下载失败";
        _failLabel.textColor = [UIColor whiteColor];
        _failLabel.backgroundColor = [UIColor clearColor];
        _failLabel.width = _failLabel.height = 80;
        _failLabel.contentMode = UIViewContentModeCenter;
        
    }
    return _failLabel;
}


- (void)setProgressColor:(UIColor *)progressColor
{
    self.progressView.progressColor = progressColor;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressView];
    self.progressView.progress = progress;

    if (progress>=1.0) {
        [self.progressView removeFromSuperview];
        [self removeFromSuperview];
    }
}

- (void)showLoading
{
    [self addSubview:self.progressView];
    _progressView.center = CGPointMake(Kwidth/2.0, KHeight/2.0);


}


- (void)showfailed
{
    [self.progressView removeFromSuperview];
    [self addSubview:self.failLabel];
    _failLabel.center = self.center;

    [UIView animateWithDuration:.25 animations:^{
        self.failLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.failLabel removeFromSuperview];
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressView.center = CGPointMake(self.width/2.0, self.height/2.0);
}
@end
