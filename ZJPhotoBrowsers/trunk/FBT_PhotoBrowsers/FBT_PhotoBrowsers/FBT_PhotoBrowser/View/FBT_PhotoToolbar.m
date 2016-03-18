//
//  FBT_PhotoToolbar.m
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_PhotoToolbar.h"
#import "UIView+Extension.h"

@interface FBT_PhotoToolbar()
{
    UILabel *_indexLable;
    UILabel *_pageLable;
}
@end

@implementation FBT_PhotoToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indexLable = [[UILabel alloc]init];
        _indexLable.textColor = [UIColor whiteColor];
        _indexLable.font = [UIFont systemFontOfSize:15];
        _indexLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_indexLable];
        
        _pageLable = [[UILabel alloc]init];
        _pageLable.textAlignment = NSTextAlignmentRight;
        _pageLable.textColor = [UIColor whiteColor];
        _pageLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:_pageLable];
    }
    return self;
}

- (void)setTotalPhoto:(NSInteger)totalPhoto
{
    _pageLable.text = [NSString stringWithFormat:@"%ld/",(long)totalPhoto];
}

- (void)setCurrectIndex:(NSInteger)currectIndex
{
    _indexLable.text = [NSString stringWithFormat:@"%ld",currectIndex];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _pageLable.frame = CGRectMake(0, 0, self.width/2.0-1, self.height);
    _indexLable.frame = CGRectMake(self.width/2.0, 0, self.width/2.0, self.height);
}



@end
