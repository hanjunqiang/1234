//
//  FBI_Operation.m
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/22.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBI_Operation.h"
#import "NSCache+FBI_Cache.h"

@interface FBI_Operation()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURL *_currectURL;
}

#define IntervalTime 30
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSMutableData* receivedData;
@property (nonatomic, copy) FBIequestSuccessHandler successHandler;
@property (nonatomic, copy) FBIRequestErrorHandler errorHandler;

@end

@implementation FBI_Operation

- (instancetype)initWithURL:(NSURL *)URL Success:(FBIequestSuccessHandler)success error:(FBIRequestErrorHandler)error
{
    self = [super init];
    if (self) {
        _currectURL = URL;
        _successHandler = success;
        _errorHandler = error;
        _receivedData = [NSMutableData data];
    }
    return self;
}


-(void)start
{
    [super start];
    NSLog(@".....%@........startstartstartstartstartstartstart",[NSThread currentThread]);

    dispatch_async(dispatch_get_main_queue(), ^{
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:_currectURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:IntervalTime];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _connection = connection;
    [connection start];
    
});

}

- (void) requestDidEnd
{
    [_connection cancel];
    _connection = nil;
    
    _successHandler = nil;
    _errorHandler = nil;
    _response = nil;
    _receivedData = nil;
}

- (void) cancel
{
    [self endWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
}


- (void) endWithError:(NSError *)error
{
    if ( error ) {
        if (_errorHandler) {
            (_errorHandler)(error);
        }
    } else {
        if ( _successHandler ) {
            [[NSCache shareCache] saveImageFromName:_currectURL.absoluteString data:_receivedData];
            _successHandler( [[UIImage alloc] initWithData:_receivedData], _response);
        }
    }
    
    [self requestDidEnd];
}

#pragma mark - NSURLConnectionDelegate


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self endWithError:nil];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self endWithError:error];
}

#pragma mark - NSURLConnectionDelegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //响应是否出错
    _response = (NSHTTPURLResponse *)response;
    
    if (![response respondsToSelector:@selector(statusCode)] || [((NSHTTPURLResponse *)response) statusCode] < 400)
    {
        
    }else{
        
        //响应出错
        [_connection cancel];
        NSError *error = [NSError errorWithDomain:@"Domain" code:[(NSHTTPURLResponse *)response statusCode] userInfo:[NSDictionary dictionaryWithObject:@"服务器响应错误" forKey:@"Domain"]];
        [self endWithError:error];
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receivedData appendData:data];
}



@end
