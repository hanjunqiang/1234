//
//  FBT_LoadingView.h
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBT_LoadingView : UIView

@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign) CGFloat progress;

- (void)showLoading;
- (void)showfailed;

@end
