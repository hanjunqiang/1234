//
//  UIImageView+FBI_ImageView.m
//  FBI_URLImages
//
//  Created by 张杰 on 16/2/21.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "UIImageView+FBI_ImageView.h"
#import <objc/runtime.h>
#import "NSCache+FBI_Cache.h"
#import "FBI_ImageDownload.h"

static char imageURL;
static char _spinner;

@implementation UIImageView (FBI_ImageView)

- (NSString *)currentRequest
{
    return  objc_getAssociatedObject(self, &imageURL);
    
}

- (void)setCurrentRequest:(NSString *)currentRequest
{
    objc_setAssociatedObject(self, &imageURL, currentRequest, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)spinner
{
   UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = (CGPoint){ CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) };
    spinner.hidesWhenStopped = YES;
    objc_setAssociatedObject(self, &_spinner, spinner, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return objc_getAssociatedObject(self, &_spinner);
}

- (void)setSpinner:(UIActivityIndicatorView *)spinner
{

}

- (void)imageWithURL:(NSString *)URL andPlacehodel:(UIImage *)placeimage
{
    if ( !URL || [URL isEqualToString:self.currentRequest]) return;
    if (placeimage) {
        self.image = placeimage;
    }
    
    NSURL *url = [NSURL URLWithString:URL];
    [[NSCache shareCache] imageForURL:url found:^(UIImage *image) {
        

        self.image = image;
    } notFound:^{
        
        if ( !self.spinner.superview ) {//没有添加到imageview上面
            [self addSubview:self.spinner];
        }
        [self.spinner startAnimating];
        
        [[FBI_ImageDownload shareDownload] downloadImageWithURL:url Success:^(UIImage *image, NSHTTPURLResponse *response) {
            [self stopSpinner];
            if (image) {
                self.image = image;
                [[NSCache shareCache] saveImageFromName:url.absoluteString data:UIImagePNGRepresentation(image)];
            }
            
            
        } error:^(NSError *error) {
            
            [self stopSpinner];

            
        }];
    }];

}

- (void) stopSpinner;
{
    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];
}


@end
