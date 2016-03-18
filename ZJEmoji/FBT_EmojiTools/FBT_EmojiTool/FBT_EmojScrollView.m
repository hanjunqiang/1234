//
//  FBT_emojScrollView.m
//  FBT_PublishTool
//
//  Created by 张杰 on 16/2/29.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_EmojScrollView.h"
#import "UIView+ZJExtension.h"

static const int ImageWith = 30;
static const int insert = 15; //边距
static const int lineNum = 7; //列数
static const int rowNum = 4;// 行数

@interface FBT_EmojScrollView()<UIScrollViewDelegate>
{
    EmojSelectedBlock _selectedBlock;

}
@property (nonatomic, strong) NSArray *emojArray;
@property (nonatomic, strong) UIPageControl *pagecontrol;
@property (nonatomic, strong) UIScrollView *emojiScrollView;

@end

@implementation FBT_EmojScrollView


- (instancetype)initWithFrame:(CGRect)frame EmojScrollView:(EmojSelectedBlock)selecteBlock
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        _selectedBlock = selecteBlock;
        [self addSubview:self.emojiScrollView];
        [self addSubview:self.pagecontrol];
        [self addTheEmojImage];
    }
    return self;
}

- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc]init];
        _pagecontrol.zj_y = self.zj_h - 30;
        _pagecontrol.zj_w = 100;
        _pagecontrol.zj_h = 20;
        _pagecontrol.zj_x = (KScreenW - _pagecontrol.zj_w)/2;
        _pagecontrol.currentPageIndicatorTintColor = [UIColor redColor];
        _pagecontrol.pageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pagecontrol;
}

- (UIScrollView *)emojiScrollView
{
    if (!_emojiScrollView) {
        
        _emojiScrollView = [[UIScrollView alloc]initWithFrame:self.frame];
        _emojiScrollView.zj_x = _emojiScrollView.zj_y = 0;
        _emojiScrollView.pagingEnabled = YES;
        _emojiScrollView.delegate  = self;
    }
    return _emojiScrollView;
}

- (NSArray *)emojArray
{
    if (!_emojArray) {
        
        NSString *soucePath = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:soucePath];
        _emojArray = dict[@"emoticon_group_emoticons"];
        
    }
    return _emojArray;
}


- (void)addTheEmojImage
{
    int total = (int)self.emojArray.count;
    int count = lineNum*rowNum;
    int result = total%count;
    int backViewNum = total/count;
    if (result!=0) {
        backViewNum += 1;
    }
    CGFloat  Kmargin = (KScreenW - ImageWith*lineNum- insert*2)/(lineNum-1);
    self.pagecontrol.numberOfPages = backViewNum;
    
    self.emojiScrollView.contentSize = CGSizeMake(backViewNum*KScreenW, 0);
    for (int i = 0; i<backViewNum; i++) {
        UIView *backView = [[UIView alloc]initWithFrame:self.frame];
        backView.zj_x = i*KScreenW;
        [self.emojiScrollView addSubview:backView];
        int pageCnt = count;
        if (i==backViewNum-1) {
            pageCnt = result;
        }
        for (int j = 0; j<pageCnt; j++) {
            FBT_EmojiButton *btn= [[FBT_EmojiButton alloc]init];
            btn.zj_x = insert + (j%lineNum) * (Kmargin+ImageWith);
            btn.zj_y = insert + (j/lineNum) * (Kmargin+ImageWith);
            btn.zj_w = btn.zj_h = ImageWith;
            int tag = i*count + j;
            btn.tag = tag;
            NSDictionary *dict = self.emojArray[tag];
            btn.dict = dict;
            [btn addTarget:self action:@selector(emojbtnclicked:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
        }
    }
}


- (void)emojbtnclicked:(FBT_EmojiButton *)btn
{
    _selectedBlock(btn.textAttachment);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pagecontrol.currentPage = (scrollView.contentOffset.x + KScreenW/2)/KScreenW;
}

#pragma mark - 隐藏page
- (void)setHiddenPageControl:(BOOL)hiddenPageControl
{
    self.pagecontrol.hidden = hiddenPageControl;
}

@end
