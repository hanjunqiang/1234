//
//  FBl_DBTool.h
//  越野e族
//
//  Created by 张杰 on 15/12/28.
//  Copyright © 2015年 罗树新. All rights reserved.
//

#import <Foundation/Foundation.h>
#define FBIDBTOOL [[FBl_DBTool alloc]init]

@interface FBl_DBTool : NSObject

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *huifubbsid;
@property(nonatomic,strong)NSString *fabiaogid;
@property(nonatomic,strong)NSString *weiboid;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *huifubbsfid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *columns;
@property(nonatomic,strong)NSString * image;

@property (nonatomic, copy) NSString *draftId;

/**
 *  查询所有内容
 *
 *  @return 返回内容数组
 */
- (NSMutableArray *)findalldata;

/**
 *  通过字段查询
 *
 *  @param type 查询类型
 */
- (NSMutableArray *)findallbytheColumns:(NSString *)type;

/**
 *  删除
 *
 *  @param selectId 主键id
 */
- (BOOL)deleteContentBytheId:(NSString *)selectId;

/**
 *  插入
 */
- (BOOL)addtype:(NSString *)thetype content:(NSString *)thecontent date:(NSString *)thedate username:(NSString *)theusername fabiaogid:(NSString *)thefabiaogid huifubbsid:(NSString *)thebbsid weiboid:(NSString *)theweiboid thehuifubbsfid:(NSString*)_fid thetitle:(NSString*)_title columns:(NSString *)_columns image:(NSString *)_image;


@end
