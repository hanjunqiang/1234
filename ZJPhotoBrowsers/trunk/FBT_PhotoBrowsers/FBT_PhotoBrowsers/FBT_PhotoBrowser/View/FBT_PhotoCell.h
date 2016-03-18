//
//  FBT_PhotoCell.h
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBT_PhotoCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgURL;
@property (nonatomic, copy) NSString *placeImg;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger totalPage;

@end
