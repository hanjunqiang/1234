//
//  FBT_emojKeyBar.h
//  FBT_PublishTool
//
//  Created by 张杰 on 16/2/29.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBT_EmojKeyBar;
typedef enum {
    FBKeybarDefult = 1,
    FBKeybarEmoji = 1 << 1, //表情
    FBKeybarPhoto = 1 << 2,//图片
    FBKeybarLoction = 1 << 3,//定位
    FBKeybarTalk = 1 << 4,//话题
    FBKeybarVoice = 1 << 5 //语音
}FBKeybarType;

@protocol  FBT_emojKeyBarDelegate <NSObject>

- (void)keybar:(FBT_EmojKeyBar *)keybar InselectedKeyBarType:(FBKeybarType)keybarType;

@end

@interface FBT_EmojKeyBar : UIView

@property (nonatomic, weak) id<FBT_emojKeyBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andType:(FBKeybarType)keybarType;

@end
