//
//  FBT_PhotoController.h
//  FBT_PhotoBrowsers
//
//  Created by 张杰 on 16/3/9.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FBT_PhotoController;

@protocol FBT_PhotoControllerDelegate <NSObject>

@optional
- (void)photoBrowser:(FBT_PhotoController *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;

@end
@interface FBT_PhotoController : UIViewController

@property (nonatomic, assign) NSInteger currentPhotoIndex;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign) NSString *placeImg;
@property (nonatomic, weak) id<FBT_PhotoControllerDelegate> delegate;

- (void)show;

@end



