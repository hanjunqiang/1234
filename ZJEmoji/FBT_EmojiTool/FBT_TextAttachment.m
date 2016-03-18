//
//  FBT_TextAttachment.m
//  FBT_PublishTool
//
//  Created by 张杰 on 16/3/2.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_TextAttachment.h"

@implementation FBT_TextAttachment

- (instancetype)initwithDict:(NSDictionary *)dict
{
    
    if (self == [super init]) {
        self.chs = dict[@"chs"];
        self.png = dict[@"png"];
        self.cht = dict[@"cht"];
        self.image = [UIImage imageNamed:dict[@"png"]];
    }
    return self;
}

@end

