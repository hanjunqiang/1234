//
//  FBT_PhotoController.m
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FBT_PhotoController.h"
#import "FBT_PhotoCell.h"

#define Kwidth   [UIScreen mainScreen].bounds.size.width
#define KHeight   [UIScreen mainScreen].bounds.size.height
static  NSString *identifier = @"fbtphotocell";

@interface FBT_PhotoController()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *photoCollectionView;

@end

@implementation FBT_PhotoController

- (void)viewDidLoad
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.itemSize = self.view.frame.size;
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowlayout];
    self.photoCollectionView = collection;
    collection.delegate = self;
    collection.dataSource = self;
    collection.pagingEnabled = YES;
    collection.bounces = NO;
    [self.view addSubview:collection];
    
    [collection registerClass:[FBT_PhotoCell class] forCellWithReuseIdentifier:identifier];
    collection.contentSize = CGSizeMake(10*Kwidth, KHeight);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectionViewdidTap)];
    [collection addGestureRecognizer:tap];
    
    
}

- (void)viewDidLayoutSubviews
{
    NSIndexPath *index = [NSIndexPath indexPathForItem:self.currentPhotoIndex inSection:0];
    [self.photoCollectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

}

- (void)setPlaceImg:(NSString *)placeImg
{
    _placeImg = placeImg;
    
    [self.photoCollectionView reloadData];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FBT_PhotoCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    collectionCell.totalPage = self.photos.count;
    collectionCell.currentIndex = indexPath.item;
    collectionCell.placeImg = @"weibo_implace";
    if (self.placeImg) {
        collectionCell.placeImg = self.placeImg;
    }
    collectionCell.imgURL = self.photos[indexPath.item];
    return collectionCell;
}


- (void)show
{
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    [keywindow addSubview:self.view];
    [keywindow.rootViewController addChildViewController:self];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)collectionViewdidTap
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
