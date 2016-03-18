//
//  NSCache+FBI_Cache.h
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/21.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSCache (FBI_Cache)

+ (instancetype)shareCache;

- (void)imageForURL:(NSURL *)imageURL found:(void(^)(UIImage* image))found notFound:(void(^)())notFound;
- (BOOL)saveImageFromName:(NSString *)imageName data:(NSData *)imageData;

@end
