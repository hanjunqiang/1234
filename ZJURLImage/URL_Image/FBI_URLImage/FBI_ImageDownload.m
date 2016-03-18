//
//  FBI_ImageDownload.m
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/22.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBI_ImageDownload.h"
#import "FBI_Operation.h"

#define maxCurrentOpertion 3

@interface FBI_ImageDownload()

@property (nonatomic, strong) NSOperationQueue *operationqueqes;

@end
@implementation FBI_ImageDownload

- (NSOperationQueue *)operationqueqes
{
    if (!_operationqueqes) {
        
        _operationqueqes = [[NSOperationQueue alloc]init];
        _operationqueqes.maxConcurrentOperationCount = maxCurrentOpertion;
    }
    return _operationqueqes;
}


+ (instancetype)shareDownload
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}


- (void) downloadImageWithURL:(NSURL *)URL Success:(FBIequestSuccessHandler)success error:(FBIRequestErrorHandler)errors
{
    FBI_Operation *operation = [[FBI_Operation alloc]initWithURL:URL Success:^(UIImage *image, NSHTTPURLResponse *response) {
        if (success) {
            success(image,response);
            
        }
    } error:^(NSError *error) {
        if (errors) {
            errors(error);
        }
    }];
    [self.operationqueqes addOperation:operation];
}
@end
