//
//  FBT_PhotoCell.m
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_PhotoCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "FBT_LoadingView.h"
#import "FBT_PhotoToolbar.h"

#define Kwidth   [UIScreen mainScreen].bounds.size.width
#define KHeight   [UIScreen mainScreen].bounds.size.height
@interface FBT_PhotoCell()<UIScrollViewDelegate>
{
    UIImageView *_imageView;
    FBT_LoadingView *_loadingView;
    FBT_PhotoToolbar *_Toolbar;
    UIScrollView *_srollView;
}

@end

@implementation FBT_PhotoCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addsubviews];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


- (void)addsubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    _srollView= scrollView;
    scrollView.delegate = self;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    _imageView = imageView;
    _imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageviewDidTap)];
    tap.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:tap];
    
    FBT_LoadingView *loadingView = [[FBT_LoadingView alloc]init];
    _loadingView = loadingView;
    _loadingView.frame = CGRectMake(0, 0, 80, 80);
    _loadingView.center = CGPointMake(self.width/2.0, self.height/2.0);
    [self addSubview:loadingView];
    
    FBT_PhotoToolbar *toolBar = [[FBT_PhotoToolbar alloc]init];
    toolBar.frame = CGRectMake(0, 30, 80, 80);
    toolBar.centerX = self.width/2.0;
    
    _Toolbar = toolBar;
    [self addSubview:toolBar];
    

}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _Toolbar.currectIndex = currentIndex;
}

- (void)setTotalPage:(NSInteger)totalPage
{
    _Toolbar.totalPhoto = totalPage;

}

- (void)setImgURL:(NSString *)imgURL
{
    [_imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:self.placeImg] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //进度
        
        if (expectedSize==0) {
            _loadingView.progress = .01;
        }
        _loadingView.progress = (CGFloat)receivedSize/expectedSize;
        [_loadingView showLoading];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //下载完成
        if (image) {
            _imageView.image = image;
            
        }else{
            [_loadingView showfailed];
        }
        [self setNeedsDisplay];
        
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _srollView.height = self.height;
    _srollView.width = self.width;
    
    CGSize imgsize = _imageView.image.size;
    CGFloat width = imgsize.width;
    CGFloat heigh = imgsize.height;
    CGFloat scale = width/heigh;
    width = Kwidth;
    heigh = width/scale;
    _imageView.size = CGSizeMake(Kwidth, heigh);
    _imageView.center = CGPointMake(self.width*.5, self.height*.5);
    
    
//    _loadingView.width = _loadingView.height = 80;
//    _loadingView.center = self.center;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;

}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

- (void)imageviewDidTap
{

}
@end
