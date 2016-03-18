//
//  FBT_TextView.m
//  FBT_PublishTool
//
//  Created by 张杰 on 16/2/29.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_TextView.h"

#define KScreenW  [UIScreen mainScreen].bounds.size.width
#define KScreenH  [UIScreen mainScreen].bounds.size.height

@interface FBT_TextView()<UITextViewDelegate>

@property (nonatomic, weak) UILabel *placeLabel;

@end

@implementation FBT_TextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:9];
        self.delegate = self;
        [self setupThePlacehodle];
        
    }
    return self;
}

- (void)setPlocehodel:(NSString *)plocehodel
{
    self.placeLabel.text = plocehodel;
}

- (void)setupThePlacehodle
{
    UILabel *placehodelb = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, KScreenW, 20)];
    placehodelb.text = @"请输入文字";
    placehodelb.textColor = [UIColor grayColor];
    placehodelb.font = [UIFont systemFontOfSize:17];
    self.placeLabel = placehodelb;
    [self addSubview:placehodelb];
    
}



- (void)oppendEmotion:(FBT_TextAttachment *)attachment
{
    NSMutableAttributedString *attriutestring = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];;
    
    //插入的位置
    NSInteger insertIndex = self.selectedRange.location;
    NSAttributedString *att = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriutestring insertAttributedString:att atIndex:insertIndex];
    [attriutestring addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attriutestring.length)];
    self.attributedText = attriutestring;
    self.selectedRange = NSMakeRange(insertIndex+1, 0);
    self.placeLabel.hidden = YES;
}

-  (NSString *)realstring
{
    NSMutableString *string = [NSMutableString string];
    
    //遍历富文本
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary * attrs, NSRange range, BOOL * _Nonnull stop) {
        
        FBT_TextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {
            [string appendString:attach.cht];
        }else{
            NSString *str = [self.attributedText attributedSubstringFromRange:range].string;
            [string appendString:str];
        }
    }];
    return string;
    
}

#pragma mark - delegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.placeLabel.hidden = (textView.text.length>0)? YES: NO;
}

@end
