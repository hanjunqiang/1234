//
//  FBT_EmojiButton.h
//  FBT_PublishTool
//
//  Created by 张杰 on 16/3/2.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBT_TextAttachment.h"

@interface FBT_EmojiButton : UIButton

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) FBT_TextAttachment *textAttachment;

@end
