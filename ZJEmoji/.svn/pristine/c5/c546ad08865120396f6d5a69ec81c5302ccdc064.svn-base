//
//  FBT_emojKeyBar.m
//  FBT_PublishTool
//
//  Created by 张杰 on 16/2/29.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_EmojKeyBar.h"
#import "FBI_KeybarTypeButton.h"
#import "FBT_EmojScrollView.h"
#import "UIView+ZJExtension.h"

#define keybarButtonWith KScreenW/5.0
@interface FBT_EmojKeyBar()
{
    FBKeybarType _keybarType;
    NSArray *_imageArray;
    
}

@property (nonatomic, strong) NSMutableDictionary *imagebtnDict;
@property (nonatomic, strong) NSMutableArray *btnArray;

@end

@implementation FBT_EmojKeyBar


- (NSMutableDictionary *)imagebtnDict
{
    if (!_imagebtnDict) {
        _imagebtnDict = [NSMutableDictionary dictionary];
    }
    return _imagebtnDict;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame andType:(FBKeybarType)keybarType
{
    self = [super initWithFrame:frame];
    if (self) {
        _keybarType = keybarType;
        _imageArray = @[@"emoji",@"photo",@"loction",@"tallk",@"at"];
        [self addkeyboardSubViews];
        
    }
    return self;
}

- (void)addkeyboardSubViews
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = .5;
    line.frame = CGRectMake(0, 0, KScreenW, .5);
    [self addSubview:line];
    for (int i=1; i<=_imageArray.count; i++) {
        FBI_KeybarTypeButton *btn = [[FBI_KeybarTypeButton alloc]init];
        [btn setImage:[UIImage imageNamed:_imageArray[i-1]] forState:UIControlStateNormal];

        [self keyBarBtnWithType:btn andIndex:i];
        [self.imagebtnDict setObject:btn forKey:_imageArray[i-1]];
        [self.btnArray addObject:btn];
        
    }
    [self compareKeybarType];

}

- (void)compareKeybarType
{
    if (_keybarType==FBKeybarDefult) {
        
        [self layoutkeybarbutton];
        
    }else{
        
        if (!(_keybarType & FBKeybarEmoji)) {
            [self btnremoveFromSuperview:@"emoji"];
        }
        if (!(_keybarType & FBKeybarLoction)) {
            [self btnremoveFromSuperview:@"loction"];
        }
        if (!(_keybarType & FBKeybarPhoto)) {
            [self btnremoveFromSuperview:@"photo"];
        }
        if (!(_keybarType & FBKeybarTalk)) {
            [self btnremoveFromSuperview:@"tallk"];
        }
        if (!(_keybarType & FBKeybarVoice)) {
            [self btnremoveFromSuperview:@"at"];
        }
        
        [self layoutkeybarbutton];
        
    }
    
}

- (void)btnremoveFromSuperview:(NSString *)Key{
    
    UIButton *btn = self.imagebtnDict[Key];
    [self.imagebtnDict removeObjectForKey:Key];
    [self.btnArray removeObject:btn];
    

}

- (void)layoutkeybarbutton
{
    
    for (int i=0; i<self.btnArray.count; i++) {
        FBI_KeybarTypeButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(i*keybarButtonWith, 0, keybarButtonWith, self.zj_h);
        [btn addTarget:self action:@selector(keybarbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
    }
}

- (void)keyBarBtnWithType:(FBI_KeybarTypeButton *)keybarBtn andIndex:(int)index
{
    switch (index) {
        case 1:
            keybarBtn.keybarType = FBKeybarEmoji;
            break;
        case 2:
            keybarBtn.keybarType = FBKeybarPhoto;
            break;
        case 3:
            keybarBtn.keybarType = FBKeybarLoction;
            break;
        case 4:
            keybarBtn.keybarType = FBKeybarTalk;
            break;
        case 5:
            keybarBtn.keybarType = FBKeybarVoice;
            break;
        default:
            break;
    }

}

#pragma mark -delegate
- (void)keybarbuttonClicked:(FBI_KeybarTypeButton *)keybarBtn
{
    if ([self.delegate respondsToSelector:@selector(keybar:InselectedKeyBarType:)]) {
        
        [self.delegate keybar:self InselectedKeyBarType:keybarBtn.keybarType];
    }
    
}



@end
