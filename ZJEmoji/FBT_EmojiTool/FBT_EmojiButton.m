//
//  FBT_EmojiButton.m
//  FBT_PublishTool
//
//  Created by 张杰 on 16/3/2.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_EmojiButton.h"

@implementation FBT_EmojiButton

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    FBT_TextAttachment *attachment = [[FBT_TextAttachment alloc]initwithDict:dict];
    [self setImage:[UIImage imageNamed:attachment.png] forState:UIControlStateNormal];
    self.textAttachment = attachment;
}
@end
