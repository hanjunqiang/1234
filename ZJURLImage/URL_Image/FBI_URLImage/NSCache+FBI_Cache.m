//
//  NSCache+FBI_Cache.m
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/21.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "NSCache+FBI_Cache.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSCache (FBI_Cache)

+ (instancetype)shareCache
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}

+ (NSString *) md5:(NSString *)str
{
   
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *) localDirectory
{
    return [NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
}

- (BOOL) loadFromCacheIfPresent:(NSString *)imageName
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathOnDiskForName:imageName]];
}

- (NSString *) pathOnDiskForName:(NSString *)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.localDirectory, [NSCache md5:imageName]];
    return [NSString stringWithFormat:@"%@/%@", self.localDirectory, [NSCache md5:imageName]];
}

- (BOOL) saveImageFromName:(NSString *)imageName data:(NSData *)imageData
{
    [self setObject:imageData forKey:imageName];
    return [[NSFileManager defaultManager] createFileAtPath:[self pathOnDiskForName:imageName]
                                                   contents:imageData attributes:nil];
}

- (void) imageForURL:(NSURL *)imageURL found:(void(^)(UIImage* image))found notFound:(void(^)())notFound
{
    if ( !imageURL ) {
        return;
    }
    NSData *data = [self objectForKey:[imageURL absoluteString]];
    if (data) {
        found([UIImage imageWithData:data]);
        return;
    }
    if ( [self loadFromCacheIfPresent:[imageURL absoluteString]] ) {
        found( [[UIImage alloc] initWithContentsOfFile:[self pathOnDiskForName:[imageURL absoluteString]]] );
    } else {
        notFound();
    }

}

@end
