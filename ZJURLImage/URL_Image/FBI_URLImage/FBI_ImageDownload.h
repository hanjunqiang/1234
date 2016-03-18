//
//  FBI_ImageDownload.h
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/22.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FBI_Operation.h"

@interface FBI_ImageDownload : NSObject

+ (instancetype)shareDownload;
- (void) downloadImageWithURL:(NSURL *)URL Success:(FBIequestSuccessHandler)success error:(FBIRequestErrorHandler)error;

@end
