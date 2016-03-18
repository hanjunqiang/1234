//
//  UIImageView+FBI_ImageView.h
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/21.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (FBI_ImageView)

@property (nonatomic, copy) NSString *currentRequest;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
- (void)imageWithURL:(NSString *)URL andPlacehodel:(UIImage *)placeimage;


@end
