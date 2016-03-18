//
//  FBT_emojScrollView.h
//  FBT_PublishTool
//
//  Created by 张杰 on 16/2/29.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBT_EmojiButton.h"

#define KScreenW  [UIScreen mainScreen].bounds.size.width
#define KScreenH  [UIScreen mainScreen].bounds.size.height

typedef void(^EmojSelectedBlock)(FBT_TextAttachment *textAttachment);

@interface FBT_EmojScrollView : UIView

@property (nonatomic, assign) BOOL hiddenPageControl;
- (instancetype)initWithFrame:(CGRect)frame EmojScrollView:(EmojSelectedBlock)selecteBlock;

@end
