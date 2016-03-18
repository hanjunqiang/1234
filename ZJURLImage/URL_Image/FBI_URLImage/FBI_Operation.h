//
//  FBI_Operation.h
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/22.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^FBIequestSuccessHandler)(UIImage *image, NSHTTPURLResponse *response);
typedef void (^FBIRequestErrorHandler)(NSError *error);

@interface FBI_Operation : NSOperation

- (instancetype)initWithURL:(NSURL *)URL Success:(FBIequestSuccessHandler)success error:(FBIRequestErrorHandler)error;




@end
